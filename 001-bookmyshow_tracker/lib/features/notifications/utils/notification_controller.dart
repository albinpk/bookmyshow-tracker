import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';

import '../../../core/models/models.dart';

class NotificationController {
  static const bookingAlertChannelKey = 'booking_alert_channel';

  static Future<bool> init() {
    return AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: bookingAlertChannelKey,
          channelName: 'Booking alerts',
          channelDescription: 'Notification when booking available',
          importance: NotificationImportance.Max,
          playSound: true,
          enableVibration: true,
        ),
      ],
      debug: kDebugMode,
    );
  }

  static Future<bool> showBookingAvailableNotification(Movie movie) {
    return AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(1000),
        channelKey: bookingAlertChannelKey,
        title: Emojis.activites_balloon + movie.title,
        body: 'Booking available for movie "${movie.title}"',
        wakeUpScreen: true,
        criticalAlert: true,
      ),
    );
  }
}
