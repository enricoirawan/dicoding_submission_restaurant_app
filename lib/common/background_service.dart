import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:submission_dicoding_app/data/api/api_service.dart';
import 'package:submission_dicoding_app/data/model/restaurant.dart';
import 'package:submission_dicoding_app/main.dart';

import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper _notificationHelper = NotificationHelper();

    ///entah kenapa saya mau panggil instance api service dari DI dari getIt malah kena error, jadi nya saya pake DI manual
    List<Restaurant> results = await ApiService(dio: Dio()).getRestaurantList();

    final _random = Random();
    Restaurant element = results[_random.nextInt(results.length)];

    await _notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      element,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
