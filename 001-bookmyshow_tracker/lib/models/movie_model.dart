import 'dart:convert';

import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  const Movie({
    required this.title,
    required this.url,
    this.isBookingAvailable = false,
    this.trackingEnabled = true,
    this.lastChecked,
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

  /// Last checked time.
  final DateTime? lastChecked;

  @override
  List<Object?> get props {
    return [
      title,
      url,
      isBookingAvailable,
      trackingEnabled,
      lastChecked,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'url': url,
      'isBookingAvailable': isBookingAvailable,
      'trackingEnabled': trackingEnabled,
      'lastChecked': lastChecked?.millisecondsSinceEpoch,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] as String,
      url: map['url'] as String,
      isBookingAvailable: map['isBookingAvailable'] as bool,
      trackingEnabled: map['trackingEnabled'] as bool,
      lastChecked: map['lastChecked'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastChecked'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);

  Movie copyWith({
    String? title,
    String? url,
    bool? isBookingAvailable,
    bool? trackingEnabled,
    DateTime? lastChecked,
  }) {
    return Movie(
      title: title ?? this.title,
      url: url ?? this.url,
      isBookingAvailable: isBookingAvailable ?? this.isBookingAvailable,
      trackingEnabled: trackingEnabled ?? this.trackingEnabled,
      lastChecked: lastChecked ?? this.lastChecked,
    );
  }
}
