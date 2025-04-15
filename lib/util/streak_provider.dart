import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreakCoinProvider extends ChangeNotifier {
  int _streak = 0;

  int get streak => _streak;

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    _streak = prefs.getInt('streak') ?? 1;
    notifyListeners();
  }

  Future<void> updateStreakWithDate() async {
    final prefs = await SharedPreferences.getInstance();
    final lastOpened = prefs.getString('lastOpenedDate');
    final today = DateTime.now();

    if (lastOpened != null) {
      final lastDate = DateTime.parse(lastOpened);
      final difference = today.difference(lastDate).inDays;

      if (difference == 1) {
        _streak = (prefs.getInt('streak') ?? 0) + 1;
      } else if (difference > 1) {
        _streak = 1;
      }
    } else {
      _streak = 1;
    }

    prefs.setInt('streak', _streak);
    prefs.setString('lastOpenedDate', today.toIso8601String());
    notifyListeners();
  }
}
