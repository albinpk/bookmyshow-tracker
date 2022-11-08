import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/models.dart';
import '../utils/workmanager_controller.dart';

part 'background_fetch_state.dart';

const _isBackgroundFetchActiveKey = 'isBackgroundFetchActive';
const _backgroundFetchDurationKey = 'backgroundFetchDuration';

class BackgroundFetchCubit extends Cubit<BackgroundFetchState> {
  BackgroundFetchCubit(this._pref)
      : super(BackgroundFetchState.initial(_pref)) {
    WorkmanagerController.isBackgroundTaskStarted = state.isActive;
  }

  final SharedPreferences _pref;

  /// Start the background task.
  Future<void> start() async {
    if (state.isActive) return;
    await _pref.setBool(_isBackgroundFetchActiveKey, true);
    await WorkmanagerController.startBackgroundTask(state.frequency.duration);
    emit(state.copyWith(isActive: true));
  }

  /// Stop the background task.
  Future<void> stop() async {
    if (!state.isActive) return;
    await _pref.setBool(_isBackgroundFetchActiveKey, false);
    await WorkmanagerController.stopBackgroundTask();
    emit(state.copyWith(isActive: false));
  }

  /// Change background task frequency.
  Future<void> changeFrequency(BackgroundTaskFrequency frequency) async {
    _pref.setString(_backgroundFetchDurationKey, frequency.name);
    if (state.isActive) {
      await WorkmanagerController.startBackgroundTask(frequency.duration);
    }
    emit(state.copyWith(frequency: frequency));
  }
}
