import 'package:flutter/material.dart';
import 'package:readtrack/core/constants/app_constants.dart';
import 'package:readtrack/core/services/storage_service.dart';

class HomeViewModel extends ChangeNotifier {
  final StorageService _storage;

  HomeViewModel(this._storage) {
    _load();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _todayMinutes = 0;
  int get todayMinutes => _todayMinutes;

  int _currentStreak = 0;
  int get currentStreak => _currentStreak;

  int _dailyGoal = AppConstants.defaultDailyGoal;
  int get dailyGoal => _dailyGoal;

  bool get goalReached => _todayMinutes >= _dailyGoal;

  double get goalProgress =>
      _dailyGoal > 0 ? (_todayMinutes / _dailyGoal).clamp(0.0, 1.0) : 0.0;

  /// Last 7 days (today last), minutes each day
  List<int> _weeklyPreview = List.filled(7, 0);
  List<int> get weeklyPreview => _weeklyPreview;

  DateTime get _today => _normalise(DateTime.now());

  DateTime _normalise(DateTime d) => DateTime(d.year, d.month, d.day);

  Future<void> _load() async {
    _isLoading = true;
    notifyListeners();

    final goalStr = _storage.getSetting(AppConstants.dailyGoalKey);
    if (goalStr != null) {
      _dailyGoal = int.tryParse(goalStr) ?? AppConstants.defaultDailyGoal;
    }

    _todayMinutes = _storage.getLog(_today);
    _weeklyPreview = _buildWeeklyPreview();
    _currentStreak = _computeStreak();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logMinutes(int minutes) async {
    await _storage.saveLog(_today, minutes);
    _todayMinutes = minutes;
    _weeklyPreview = _buildWeeklyPreview();
    _currentStreak = _computeStreak();
    notifyListeners();
  }

  void updateDailyGoal(int goal) {
    _dailyGoal = goal;
    notifyListeners();
  }

  Future<void> refresh() => _load();

  List<int> _buildWeeklyPreview() {
    final days = List.generate(
      7,
      (i) => _normalise(_today.subtract(Duration(days: 6 - i))),
    );
    return days.map((d) => _storage.getLog(d)).toList();
  }

  int _computeStreak() {
    int streak = 0;
    DateTime cursor = _today;

    // If nothing logged today, start looking from yesterday
    if (_storage.getLog(cursor) == 0) {
      cursor = _normalise(cursor.subtract(const Duration(days: 1)));
    }

    while (true) {
      final mins = _storage.getLog(cursor);
      if (mins > 0) {
        streak++;
        cursor = _normalise(cursor.subtract(const Duration(days: 1)));
      } else {
        break;
      }
    }
    return streak;
  }
}
