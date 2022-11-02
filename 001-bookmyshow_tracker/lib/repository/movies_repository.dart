import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

import '../models/models.dart';

class MoviesRepository extends ChangeNotifier {
  MoviesRepository(this._localStorage) {
    // Get movies from local storage
    _getMovies();
  }

  /// LocalStorage instance.
  final LocalStorage _localStorage;

  /// List of [Movie]s.
  List<Movie> get movies => _movies;
  List<Movie> _movies = [];

  static const _storageKey = 'movies';

  /// Get movies from local storage.
  Future<void> _getMovies() async {
    await _localStorage.ready;
    _movies = (_localStorage.getItem(_storageKey) as List? ?? [])
        .map((e) => Movie.fromJson(e))
        .toList();
    if (_movies.isNotEmpty) notifyListeners();
  }

  /// Save current movies list to localStorage.
  Future<void> _setMovies() async {
    try {
      await _localStorage.setItem(_storageKey, _movies);
    } catch (e) {
      log('Error saving localStorage', error: e);
    }
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
