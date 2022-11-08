/// Enum of background task frequencies.
enum BackgroundTaskFrequency {
  /// Duration of 5 hours.
  hour5(Duration(hours: 5), '5 hour'),

  /// Duration of 1 hours.
  hour1(Duration(hours: 1), '1 hour'),

  /// Duration of 30 minutes.
  min30(Duration(minutes: 30), '30 min'),

  /// Duration of 15 minutes.
  min15(Duration(minutes: 15), '15 min');

  /// Readable format of frequency. eg: 5 hour, 15 min
  final String name;

  /// Duration of the frequency.
  final Duration duration;

  const BackgroundTaskFrequency(this.duration, this.name);

  /// Get frequency from name.
  factory BackgroundTaskFrequency.fromName(String name) {
    return values.singleWhere((f) => f.name == name);
  }
}
