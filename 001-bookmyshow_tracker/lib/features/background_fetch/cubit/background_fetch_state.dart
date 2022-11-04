part of 'background_fetch_cubit.dart';

class BackgroundFetchState extends Equatable {
  const BackgroundFetchState({
    this.isActive = false,
  });

  final bool isActive;

  @override
  List<Object> get props => [isActive];
}
