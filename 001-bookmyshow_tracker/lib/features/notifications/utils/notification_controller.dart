import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';

class NotificationController {
  static const basicChannelKey = 'basic_chanel_key';

  static Future<bool> init() {
    return AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: basicChannelKey,
          channelName: 'Basic notifications',
          channelDescription: 'Description',
          importance: NotificationImportance.Max,
          playSound: true,
          enableVibration: true,
        ),
      ],
      debug: kDebugMode,
    );
  }

  static Future<bool> showNotification() {
    return AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: basicChannelKey,
        title: 'First notification !!!',
      ),
    );
  }
}
