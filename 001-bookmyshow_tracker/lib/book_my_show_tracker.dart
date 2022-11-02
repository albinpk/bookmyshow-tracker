import 'package:flutter/material.dart';

import 'screens/screens.dart';

class BookMyShowTracker extends StatelessWidget {
  const BookMyShowTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookmyshow Tracker',
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
