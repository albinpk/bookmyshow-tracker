import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repository/movies_repository.dart';
import 'screens/screens.dart';

class BookMyShowTracker extends StatelessWidget {
  const BookMyShowTracker({
    super.key,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MoviesRepository>(
      create: (context) => MoviesRepository(sharedPreferences),
      lazy: false,
      child: MaterialApp(
        title: 'Bookmyshow Tracker',
        darkTheme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}
