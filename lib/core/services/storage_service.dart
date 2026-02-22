import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:readtrack/core/constants/app_constants.dart';

class StorageService {
  Box<String> get _dataBox => Hive.box<String>(AppConstants.dataBox);
  Box<String> get _settingsBox => Hive.box<String>(AppConstants.settingsBox);

  // ---------- reading logs ----------

  String _logKey(DateTime date) =>
      '${AppConstants.logKeyPrefix}${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  Future<void> saveLog(DateTime date, int minutes) async {
    final key = _logKey(date);
    await _dataBox.put(key, jsonEncode({'minutes': minutes}));
  }

  int getLog(DateTime date) {
    final key = _logKey(date);
    final raw = _dataBox.get(key);
    if (raw == null) return 0;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return (map['minutes'] as num?)?.toInt() ?? 0;
    } catch (_) {
      return 0;
    }
  }

  /// Returns minutes for each day in [dates].
  Map<DateTime, int> getLogs(List<DateTime> dates) {
    return {for (final d in dates) d: getLog(d)};
  }

  // ---------- settings ----------

  Future<void> saveSetting(String key, String value) async {
    await _settingsBox.put(key, value);
  }

  String? getSetting(String key) => _settingsBox.get(key);

  // ---------- clear ----------

  Future<void> clearAll() async {
    await _dataBox.clear();
    // Keep settings – user likely wants to keep their goal / theme preference
  }
}
