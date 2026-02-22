import 'package:flutter/material.dart';
import 'package:readtrack/core/services/storage_service.dart';

class WeeklyViewModel extends ChangeNotifier {
  final StorageService _storage;

  WeeklyViewModel(this._storage) {
    load();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// List of (date, minutes) for the last 7 days, oldest first
  List<MapEntry<DateTime, int>> _days = [];
  List<MapEntry<DateTime, int>> get days => _days;

  int get totalMinutes => _days.fold(0, (sum, e) => sum + e.value);

  int get longestStreak {
    int max = 0, current = 0;
    for (final e in _days) {
      if (e.value > 0) {
        current++;
        if (current > max) max = current;
      } else {
        current = 0;
      }
    }
    return max;
  }

  int get maxMinutes {
    if (_days.isEmpty) return 1;
    final m = _days.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    return m == 0 ? 1 : m;
  }

  DateTime _normalise(DateTime d) => DateTime(d.year, d.month, d.day);

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();

    final today = _normalise(DateTime.now());
    final days = List.generate(
      7,
      (i) => _normalise(today.subtract(Duration(days: 6 - i))),
    );
    _days = days.map((d) => MapEntry(d, _storage.getLog(d))).toList();

    _isLoading = false;
    notifyListeners();
  }
}
