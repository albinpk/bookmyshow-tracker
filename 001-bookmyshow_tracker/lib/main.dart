import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'background_task.dart';
import 'book_my_show_tracker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BackgroundTask.init();

  final pref = await SharedPreferences.getInstance();
  runApp(BookMyShowTracker(sharedPreferences: pref));
}
