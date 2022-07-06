import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:submission_dicoding_app/bloc/connected_bloc/connected_bloc.dart';
import 'package:submission_dicoding_app/bloc/favorite/favorite_cubit.dart';
import 'package:submission_dicoding_app/bloc/restaurant/restaurant_bloc.dart';
import 'package:submission_dicoding_app/bloc/restaurant_detail/restaurant_detail_bloc.dart';
import 'package:submission_dicoding_app/bloc/schedule/schedule_cubit.dart';
import 'package:submission_dicoding_app/common/background_service.dart';
import 'package:submission_dicoding_app/common/notification_helper.dart';
import 'package:submission_dicoding_app/injection.dart';
import 'package:submission_dicoding_app/route.dart';
import 'package:submission_dicoding_app/common/styles.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();

  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  setup();

  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectedBloc>(
          create: (_) => ConnectedBloc(),
        ),
        BlocProvider<RestaurantBloc>(
          create: (_) => getIt<RestaurantBloc>()..add(GetListRestaurant()),
        ),
        BlocProvider<RestaurantDetailBloc>(
          create: (_) => getIt<RestaurantDetailBloc>(),
        ),
        BlocProvider<FavoriteCubit>(
          create: (_) => getIt<FavoriteCubit>(),
        ),
        BlocProvider<ScheduleCubit>(
          create: (_) => ScheduleCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.black,
                secondary: secondaryColor,
                background: backggroundColor,
              ),
          textTheme: myTextTheme,
        ),
        initialRoute: RouteGenerator.splashScreenRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
