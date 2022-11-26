import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/background_fetch/background_fetch.dart';
import 'features/movies_list/movies_list.dart';

class BookMyShowTracker extends StatelessWidget {
  const BookMyShowTracker({
    super.key,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesListCubit>(
          create: (context) => MoviesListCubit(sharedPreferences)..getMovies(),
        ),
        BlocProvider<BackgroundFetchCubit>(
          create: (context) => BackgroundFetchCubit(sharedPreferences),
        ),
      ],
      child: MaterialApp(
        title: 'Bookmyshow Tracker',
        darkTheme: ThemeData.dark(),
        home: const MoviesScreen(),
      ),
    );
  }
}
