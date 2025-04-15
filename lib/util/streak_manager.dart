import 'package:shared_preferences/shared_preferences.dart';

Future<void> updateStreak() async {
  final prefs = await SharedPreferences.getInstance();
  final lastOpened = prefs.getString('lastOpenedDate');
  final today = DateTime.now();

  if (lastOpened != null) {
    final lastDate = DateTime.parse(lastOpened);
    final difference = today.difference(lastDate).inDays;

    if (difference == 1) {
      prefs.setInt('streak', (prefs.getInt('streak') ?? 0) + 1);
    } else if (difference > 1) {
      prefs.setInt('streak', 1);
    }
  } else {
    prefs.setInt('streak', 1);
  }

  prefs.setString('lastOpenedDate', today.toIso8601String());
}
