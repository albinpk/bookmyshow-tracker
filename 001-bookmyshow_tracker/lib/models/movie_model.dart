import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  const Movie({
    required this.title,
    required this.url,
  });

  /// The movie title.
  final String title;

  /// The movie Url on bookmyshow.com.
  final String url;

  @override
  List<Object> get props => [title, url];
}
