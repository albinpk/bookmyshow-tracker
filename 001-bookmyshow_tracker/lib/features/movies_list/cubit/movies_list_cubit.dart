import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/models.dart';

part 'movies_list_state.dart';

class MoviesListCubit extends Cubit<MoviesListState> {
  MoviesListCubit(this._pref) : super(const MoviesListInitial());

  final SharedPreferences _pref;

  static const _moviesKey = 'movies';

  void getMovies() {
    final List<Movie> movies = _pref
            .getStringList(_moviesKey)
            ?.map((e) => Movie.fromJson(e))
            .toList() ??
        [];
    emit(MoviesListFetchedState(movies: movies));
  }

  _setMovies() async {
    await _pref.setStringList(
      _moviesKey,
      state.movies.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> addMovie(Movie movie) async {
    // await _setMovies([movie, ...state.movies]);
    emit(MoviesListAddedState(
      addedMovie: movie,
      movies: [movie, ...state.movies],
    ));
    _setMovies();
  }

  Future<void> removeMovie(Movie movie) async {
    final movies = state.movies.where((m) => m != movie).toList();
    emit(MoviesListRemovedState(
      removedMovie: movie,
      movies: movies,
    ));
    _setMovies();
  }

  /// Toggle `trackingEnabled` of given `movie`.
  void toggleTracking(Movie movie) {
    movie = movie.copyWith(trackingEnabled: !movie.trackingEnabled);
    final movies =
        state.movies.map((m) => m.id == movie.id ? movie : m).toList();
    emit(MoviesListToggleTrackingState(
      toggledMovie: movie,
      movies: movies,
    ));
    _setMovies();
  }

  Future<void> refresh() async {
    await _pref.reload();
    return getMovies();
  }

  /// Return `true` if the [title] or [url] is already
  /// contains in movies list. Otherwise return `false`.
  bool contains({String? title, String? url}) {
    assert(title != null || url != null);
    if (title != null) {
      if (state.movies.where((m) => m.title == title).isNotEmpty) return true;
    }
    if (url != null) {
      if (state.movies.where((m) => m.url == url).isNotEmpty) return true;
    }
    return false;
  }
}
