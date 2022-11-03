import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:workmanager/workmanager.dart';

import 'constants.dart';
import 'models/models.dart';

/// Initializing workmanager.
void workmanagerInit() {
  Workmanager().initialize(
    _callbackDispatcher,
    isInDebugMode: kDebugMode,
  );

  Workmanager().registerPeriodicTask(
    'bookmyshow-periodic-task',
    'background-fetch',
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
}

/// The callback function for workmanager.
void _callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    log('Executing task: $taskName');

    try {
      final storage = LocalStorage(localStorageFileName);
      await storage.ready;

      // Get movies from localstorage
      final List<Movie> movies = (storage.getItem('movies') as List? ?? [])
          .map((e) => Movie.fromJson(e))
          .where((m) => m.trackingEnabled)
          .toList();
      log('Movies length: ${movies.length}');

      // Check booking available
      final List<int> availableMoviesIndex = [];
      for (int i = 0; i < movies.length; i++) {
        final available = await _checkBookingAvailable(movies[i]);
        if (available) availableMoviesIndex.add(i);
      }
      log('Available movies length: ${availableMoviesIndex.length}');

      // Update localstorage if booking available
      if (availableMoviesIndex.isNotEmpty) {
        for (final i in availableMoviesIndex) {
          movies[i] = movies[i].copyWith(
            isBookingAvailable: true,
            trackingEnabled: false,
          );
        }
        await storage.setItem('movies', movies);

        storage.dispose();
      }
    } catch (e) {
      log('Background execution error', error: e);
    }

    return true;
  });
}

/// Check whether ticket booking available for the given `movie`.
Future<bool> _checkBookingAvailable(Movie movie) async {
  try {
    final res = await http.get(Uri.parse(movie.url));
    if (res.body.contains('Book tickets')) return true;
  } catch (e) {
    log('Background fetch error', error: e);
  }
  return false;
}
