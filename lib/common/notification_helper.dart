import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:submission_dicoding_app/data/model/restaurant.dart';

final selectNotificationSubject = BehaviorSubject<String?>();

class NotificationHelper {
  static const _channelId = "01";
  static const _channelName = "channel_01";
  static const _channelDesc = "dicoding channel";
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        // print('notification payload: $payload');
      }
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    Restaurant restaurant,
  ) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    var titleNotification = "Yuk mampir ke ${restaurant.name}";
    var restaurantDesc = restaurant.description;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      restaurantDesc,
      platformChannelSpecifics,
      payload: restaurant.id,
    );
  }
}
