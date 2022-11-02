import 'dart:convert';

import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  const Movie({
    required this.title,
    required this.url,
    this.isBookingAvailable = false,
    this.trackingEnabled = true,
  });

  /// Id of the movie. Same as [url].
  String get id => url;

  /// The movie title.
  final String title;

  /// The movie Url on bookmyshow.com.
  final String url;

  /// Whether ticket booking is available for this movie or not.
  final bool isBookingAvailable;

  /// Whether tracking is enabled or not.
  final bool trackingEnabled;

  @override
  List<Object> get props => [title, url, isBookingAvailable, trackingEnabled];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'url': url,
      'isBookingAvailable': isBookingAvailable,
      'trackingEnabled': trackingEnabled,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] as String,
      url: map['url'] as String,
      isBookingAvailable: map['isBookingAvailable'] as bool,
      trackingEnabled: map['trackingEnabled'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);
}
