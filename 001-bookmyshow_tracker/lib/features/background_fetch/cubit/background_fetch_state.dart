part of 'background_fetch_cubit.dart';

class BackgroundFetchState extends Equatable {
  const BackgroundFetchState({
    required this.isActive,
    required this.frequency,
  });

  BackgroundFetchState.initial(SharedPreferences pref)
      : isActive = pref.getBool(_isBackgroundFetchActiveKey) ?? false,
        frequency = Duration(
          minutes: pref.getInt(_backgroundFetchDurationKey) ?? 15,
        );

// Whether the background task in active or not.
  final bool isActive;

  /// Background task frequency. Minimum 15 minutes.
  final Duration frequency;

  @override
  List<Object> get props => [isActive, frequency];

  BackgroundFetchState copyWith({
    bool? isActive,
    Duration? frequency,
  }) {
    return BackgroundFetchState(
      isActive: isActive ?? this.isActive,
      frequency: frequency ?? this.frequency,
    );
  }
}
