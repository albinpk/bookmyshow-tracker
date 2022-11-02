import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'url': url,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) {
    return Movie.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
