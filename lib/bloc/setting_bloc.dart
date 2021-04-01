import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/setting_event.dart';
import 'package:restaurant_app/bloc/setting_state.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(Initial());
  static const String notificationPrefs = 'notification';
  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (event is SetValue) {
      yield Loading();
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(notificationPrefs, event.status);
      if (event.status) {
        await AndroidAlarmManager.periodic(
          Duration(hours: 24),
          1,
          BackgroundService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true,
        );
      } else {
        await AndroidAlarmManager.cancel(1);
      }

      add(GetValue());
    } else if (event is GetValue) {
      yield Loading();
      final prefs = await SharedPreferences.getInstance();
      bool status = prefs.getBool(notificationPrefs) ?? false;
      yield LoadData(status);
    }
  }
}
