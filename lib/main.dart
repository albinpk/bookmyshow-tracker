import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'book_my_show_tracker.dart';
import 'features/background_fetch/background_fetch.dart';
import 'features/notifications/notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WorkmanagerController.init();
  NotificationController.init();

  final pref = await SharedPreferences.getInstance();
  runApp(BookMyShowTracker(sharedPreferences: pref));
}
