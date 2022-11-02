import 'package:flutter/material.dart';

class BookMyShowTracker extends StatelessWidget {
  const BookMyShowTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookmyshow Tracker',
      darkTheme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(
          child: Text('Home'),
        ),
      ),
    );
  }
}
