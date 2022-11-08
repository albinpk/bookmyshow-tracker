import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  start() async {
    if (state.isActive) return;
    await _pref.setBool(_isBackgroundFetchActiveKey, true);
    await WorkmanagerController.startBackgroundTask();
    emit(state.copyWith(isActive: true));
  }

  stop() async {
    if (!state.isActive) return;
    await _pref.setBool(_isBackgroundFetchActiveKey, false);
    await WorkmanagerController.stopBackgroundTask();
    emit(state.copyWith(isActive: false));
  }
}
