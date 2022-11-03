import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'background_task.dart';
import 'book_my_show_tracker.dart';
import 'constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BackgroundTask.init();

  final localStorage = LocalStorage(localStorageFileName);
  runApp(BookMyShowTracker(localStorage: localStorage));
}
