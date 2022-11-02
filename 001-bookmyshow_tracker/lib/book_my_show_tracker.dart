import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'repository/movies_repository.dart';
import 'screens/screens.dart';

class BookMyShowTracker extends StatelessWidget {
  const BookMyShowTracker({
    super.key,
    required this.localStorage,
  });

  final LocalStorage localStorage;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MoviesRepository>(
      create: (context) => MoviesRepository(localStorage),
      lazy: false,
      child: MaterialApp(
        title: 'Bookmyshow Tracker',
        darkTheme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}
