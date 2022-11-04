import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../../../core/constants.dart';
import '../../../core/models/models.dart';
import '../../notifications/notifications.dart';

/// A class that contains all static method
/// to handle workmanager background task.
class WorkmanagerController {
  /// Initializing workmanager.
  static Future<void> init() {
    return Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );
  }

  /// Whether the background task started or not.
  static bool isBackgroundTaskStarted = false;

  /// Register periodic task.
  static Future<void> startBackgroundTask() async {
    if (isBackgroundTaskStarted) return;
    await Workmanager().registerPeriodicTask(
      backgroundTaskUniqName,
      'background-fetch',
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
    isBackgroundTaskStarted = true;
  }

  /// Cancel the background task.
  static Future<void> stopBackgroundTask() async {
    if (!isBackgroundTaskStarted) return;
    await Workmanager().cancelByUniqueName(backgroundTaskUniqName);
    isBackgroundTaskStarted = false;
  }
}

/// The callback function for workmanager.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    log('Executing task: $taskName');

    try {
      final pref = await SharedPreferences.getInstance();

      // Get movies from localstorage
      final List<Movie> movies = (pref.getStringList('movies') ?? [])
          .map((e) => Movie.fromJson(e))
          .where((m) => m.trackingEnabled)
          .toList();
      log('Movies length: ${movies.length}');

      // Stop the background task and exit if movies is empty
      if (movies.isEmpty) {
        await WorkmanagerController.stopBackgroundTask();
        log('Background task stop and exit');
        return true;
      }

      // Check booking available
      final List<int> availableMoviesIndex = [];
      for (int i = 0; i < movies.length; i++) {
        final available = await checkBookingAvailable(movies[i]);
        if (available) availableMoviesIndex.add(i);
        movies[i] = movies[i].copyWith(lastChecked: DateTime.now());
      }
      log('Available movies length: ${availableMoviesIndex.length}');

      // Update localstorage if booking available
      if (availableMoviesIndex.isNotEmpty) {
        for (final i in availableMoviesIndex) {
          movies[i] = movies[i].copyWith(
            isBookingAvailable: true,
            trackingEnabled: false,
          );
          NotificationController.showBookingAvailableNotification(movies[i]);
        }
      }
      await pref.setStringList(
        'movies',
        movies.map((e) => e.toJson()).toList(),
      );
    } catch (e) {
      log('Background execution error', error: e);
    }

    return true;
  });
}

/// Check whether ticket booking available for the given `movie`.
Future<bool> checkBookingAvailable(Movie movie) async {
  try {
    final res = await http.get(Uri.parse(movie.url));
    if (res.body.contains('Book tickets')) return true;
  } catch (e) {
    log('Background fetch error', error: e);
  }
  return false;
}
