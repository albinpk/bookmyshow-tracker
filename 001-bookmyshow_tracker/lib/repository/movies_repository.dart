import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../background_task.dart';
import '../models/models.dart';

class MoviesRepository extends ChangeNotifier {
  MoviesRepository(this._pref) {
    // Get movies from storage
    _getMovies();
  }

  /// SharedPreferences instance.
  final SharedPreferences _pref;

  /// List of [Movie]s.
  List<Movie> get movies => _movies;
  List<Movie> _movies = [];

  static const _storageKey = 'movies';

  /// Get movies from local storage.
  Future<void> _getMovies() async {
    final rowMovies = _pref.getStringList(_storageKey) ?? [];
    _movies = rowMovies.map((e) => Movie.fromJson(e)).toList();
    notifyListeners();
  }

  /// Save current movies list to localStorage.
  Future<void> _setMovies() async {
    try {
      await _pref.setStringList(
        _storageKey,
        _movies.map((e) => e.toJson()).toList(),
      );
    } catch (e) {
      log('Error saving to SharedPreferences', error: e);
    }

    if (_movies.where((m) => m.trackingEnabled).isEmpty) {
      BackgroundTask.stopBackgroundTask();
    }
  }

  Future<void> refresh() async {
    await _pref.reload();
    return _getMovies();
  }

  /// Add given `movie` to movies list.
  void addMovie(Movie movie) {
    _movies = [movie, ..._movies];
    notifyListeners();
    _setMovies();
  }

  /// Delete given `movie` from movies list.
  void deleteMovie(Movie movie) {
    _movies.remove(movie);
    notifyListeners();
    _setMovies();
  }

  /// Toggle `trackingEnabled` of given `movie`.
  void toggleTracking(Movie movie) {
    final index = movies.indexOf(movie);
    movies[index] = movie.copyWith(trackingEnabled: !movie.trackingEnabled);
    notifyListeners();
    _setMovies();
  }

  /// Return `true` if the [title] or [url] is already
  /// contains in movies list. Otherwise return `false`.
  bool contains({String? title, String? url}) {
    assert(title != null || url != null);
    if (title != null) {
      if (_movies.where((m) => m.title == title).isNotEmpty) return true;
    }
    if (url != null) {
      if (_movies.where((m) => m.url == url).isNotEmpty) return true;
    }
    return false;
  }
}
