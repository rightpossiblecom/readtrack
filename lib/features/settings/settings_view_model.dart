import 'package:flutter/material.dart';
import 'package:readtrack/core/constants/app_constants.dart';
import 'package:readtrack/core/services/storage_service.dart';

class SettingsViewModel extends ChangeNotifier {
  final StorageService _storage;

  SettingsViewModel(this._storage) {
    _load();
  }

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  int _dailyGoal = AppConstants.defaultDailyGoal;
  int get dailyGoal => _dailyGoal;

  void _load() {
    final themeStr = _storage.getSetting(AppConstants.themeKey);
    _themeMode = switch (themeStr) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    final goalStr = _storage.getSetting(AppConstants.dailyGoalKey);
    _dailyGoal = int.tryParse(goalStr ?? '') ?? AppConstants.defaultDailyGoal;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final str = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await _storage.saveSetting(AppConstants.themeKey, str);
    notifyListeners();
  }

  Future<void> setDailyGoal(int goal) async {
    _dailyGoal = goal;
    await _storage.saveSetting(AppConstants.dailyGoalKey, goal.toString());
    notifyListeners();
  }

  Future<void> clearAll() async {
    await _storage.clearAll();
    notifyListeners();
  }
}
