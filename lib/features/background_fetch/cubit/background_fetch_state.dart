part of 'background_fetch_cubit.dart';

class BackgroundFetchState extends Equatable {
  const BackgroundFetchState({
    required this.isActive,
    required this.frequency,
  });

  BackgroundFetchState.initial(SharedPreferences pref)
      : isActive = pref.getBool(_isBackgroundFetchActiveKey) ?? false,
        frequency = BackgroundTaskFrequency.fromName(
          pref.getString(_backgroundFetchDurationKey) ??
              BackgroundTaskFrequency.hour1.name,
        );

// Whether the background task in active or not.
  final bool isActive;

  /// Background task frequency. Minimum 15 minutes.
  final BackgroundTaskFrequency frequency;

  @override
  List<Object> get props => [isActive, frequency];

  BackgroundFetchState copyWith({
    bool? isActive,
    BackgroundTaskFrequency? frequency,
  }) {
    return BackgroundFetchState(
      isActive: isActive ?? this.isActive,
      frequency: frequency ?? this.frequency,
    );
  }
}
