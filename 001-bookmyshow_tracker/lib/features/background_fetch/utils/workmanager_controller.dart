import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

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

  /// Uniq name for workmanager background task
  static const backgroundTaskUniqName = 'bookmyshow-periodic-task';

  /// Register periodic task.
  static Future<void> startBackgroundTask() async {
    if (isBackgroundTaskStarted) return;
    await Workmanager().registerPeriodicTask(
      backgroundTaskUniqName,
      'background-fetch',
      frequency: const Duration(hours: 1),
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
    try {
      final pref = await SharedPreferences.getInstance();

      // Get movies from SharedPreferences
      final List<Movie> movies = (pref.getStringList('movies') ?? [])
          .map((e) => Movie.fromJson(e))
          .toList();

      // Check booking available
      for (int i = 0; i < movies.length; i++) {
        if (!movies[i].trackingEnabled) continue; // skip disabled movies
        final available = await checkBookingAvailable(movies[i]);
        movies[i] = movies[i].copyWith(
          lastChecked: DateTime.now(),
          isBookingAvailable: available,
          trackingEnabled: !available,
        );
        if (available) {
          NotificationController.showBookingAvailableNotification(movies[i]);
        }
      }

      // Update localstorage with updated list
      await pref.setStringList(
        'movies',
        movies.map((e) => e.toJson()).toList(),
      );

      // Cancel the background task if there
      // is no trackingEnabled movies in the list
      if (movies.where((m) => m.trackingEnabled).isEmpty) {
        await WorkmanagerController.stopBackgroundTask();
        await pref.setBool('isBackgroundFetchActive', false);
        return true;
      }
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
