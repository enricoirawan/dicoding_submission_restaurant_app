import 'dart:convert';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:submission_dicoding_app/common/background_service.dart';
import 'package:submission_dicoding_app/common/date_time_helper.dart';

part 'schedule_state.dart';

class ScheduleCubit extends HydratedCubit<ScheduleState> {
  ScheduleCubit() : super(ScheduleState.initial());

  void toggleSchedule() async {
    if (!state.isScheduled) {
      final result = await AndroidAlarmManager.periodic(
        const Duration(days: 1),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );

      emit(state.copyWith(
        isScheduled: result,
      ));
    } else {
      final result = await AndroidAlarmManager.cancel(1);

      if (result) {
        emit(state.copyWith(
          isScheduled: false,
        ));
      }
    }
  }

  @override
  ScheduleState? fromJson(Map<String, dynamic> json) {
    return ScheduleState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ScheduleState state) {
    return state.toMap();
  }
}
