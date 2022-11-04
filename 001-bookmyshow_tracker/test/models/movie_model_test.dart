import 'package:bookmyshow_tracker/core/models/movie_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Movie model', () {
    late Movie movie;

    setUpAll(() {
      movie = const Movie(title: 'title', url: 'url');
    });

    test('default initial values', () {
      expect(movie.id, 'url');
      expect(movie.isBookingAvailable, false);
      expect(movie.trackingEnabled, true);
    });

    test('JSON serialization', () {
      expect(movie, Movie.fromMap(movie.toMap()));
      expect(movie, Movie.fromJson(movie.toJson()));
    });
  });
}
