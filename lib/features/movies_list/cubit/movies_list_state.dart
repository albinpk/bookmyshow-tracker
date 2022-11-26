part of 'movies_list_cubit.dart';

abstract class MoviesListState extends Equatable {
  const MoviesListState({required this.movies});

  final List<Movie> movies;

  @override
  List<Object> get props => [movies];
}

class MoviesListInitial extends MoviesListState {
  const MoviesListInitial() : super(movies: const []);
}

class MoviesListFetchedState extends MoviesListState {
  const MoviesListFetchedState({required super.movies});
}

class MoviesListAddedState extends MoviesListState {
  const MoviesListAddedState({
    required this.addedMovie,
    required super.movies,
  });

  final Movie addedMovie;

  @override
  List<Object> get props => [addedMovie];
}

class MoviesListRemovedState extends MoviesListState {
  const MoviesListRemovedState({
    required this.removedMovie,
    required super.movies,
  });

  final Movie removedMovie;

  @override
  List<Object> get props => [removedMovie];
}

class MoviesListToggleTrackingState extends MoviesListState {
  const MoviesListToggleTrackingState({
    required this.toggledMovie,
    required super.movies,
  });

  final Movie toggledMovie;

  @override
  List<Object> get props => [toggledMovie];
}
