import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'book_my_show_tracker.dart';
import 'constants.dart';

void main() {
  final localStorage = LocalStorage(localStorageFileName);

  runApp(BookMyShowTracker(localStorage: localStorage));
}
