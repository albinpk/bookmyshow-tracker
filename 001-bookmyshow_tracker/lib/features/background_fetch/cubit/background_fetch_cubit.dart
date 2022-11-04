import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/workmanager_controller.dart';

part 'background_fetch_state.dart';

class BackgroundFetchCubit extends Cubit<bool> {
  BackgroundFetchCubit(this._pref) : super(_pref.getBool(_key) ?? false) {
    WorkmanagerController.isBackgroundTaskStarted = state;
  }

  final SharedPreferences _pref;

  static const _key = 'isBackgroundFetchActive';

  start() async {
    if (state) return;
    await _pref.setBool(_key, true);
    await WorkmanagerController.startBackgroundTask();
    emit(true);
  }

  stop() async {
    if (!state) return;
    await _pref.setBool(_key, false);
    await WorkmanagerController.stopBackgroundTask();
    emit(false);
  }
}
