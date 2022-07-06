import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_dicoding_app/bloc/schedule/schedule_cubit.dart';
import 'package:submission_dicoding_app/common/background_service.dart';
import 'package:submission_dicoding_app/common/date_time_helper.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Setting",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Aktifkan Notifikasi",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                  ),
                  BlocConsumer<ScheduleCubit, ScheduleState>(
                    listener: (context, state) async {
                      ///jika state kembalian dari hyydratedbloc nya masih true maka jalankan perintah periodic
                      if (state.isScheduled) {
                        await AndroidAlarmManager.periodic(
                          const Duration(days: 1),
                          1,
                          BackgroundService.callback,
                          startAt: DateTimeHelper.format(),
                          exact: true,
                          wakeup: true,
                        );
                      }
                    },
                    builder: (context, state) {
                      return Switch(
                        value: state.isScheduled,
                        onChanged: (_) {
                          setState(() {
                            context.read<ScheduleCubit>().toggleSchedule();
                          });
                        },
                        activeTrackColor:
                            Theme.of(context).colorScheme.secondary,
                        activeColor: Theme.of(context).colorScheme.secondary,
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
