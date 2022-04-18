import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notif/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().initialize(
    'resource://drawable/logo',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelGroupKey: 'basic_tests',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
      ),
      NotificationChannel(
        channelKey: 'badge_channel',
        channelGroupKey: 'basic_tests',
        channelName: 'Badge indicator notifications',
        channelDescription: 'Notification channel to activate badge indicator',
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'timer_notification',
        importance: NotificationImportance.High,
        enableVibration: false,
        playSound: false,
        channelName: 'Timer Notification',
        channelDescription: 'Notification channel for timer notif',
      ),
      NotificationChannel(
        channelGroupKey: 'category_tests',
        channelKey: 'call_channel',
        channelName: 'Calls Channel',
        channelDescription: 'Channel with call ringtone',
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Ringtone,
      ),
      NotificationChannel(
        channelGroupKey: 'category_tests',
        channelKey: 'alarm_channel',
        channelName: 'Alarms Channel',
        channelDescription: 'Channel with alarm ringtone',
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Alarm,
      ),
      NotificationChannel(
        channelGroupKey: 'chat_tests',
        channelKey: 'chats',
        channelName: 'Chat groups',
        channelDescription: 'This is a simple example channel of a chat group',
        channelShowBadge: true,
        importance: NotificationImportance.Max,
      ),
      NotificationChannel(
        channelGroupKey: 'layout_tests',
        channelKey: 'inbox',
        channelName: 'Inbox notifications',
        channelDescription: 'Notifications with inbox layout',
        vibrationPattern: mediumVibrationPattern,
      ),
      NotificationChannel(
        channelGroupKey: 'grouping_tests',
        channelKey: 'grouped',
        channelName: 'Grouped notifications',
        channelDescription: 'Notifications with group functionality',
        groupKey: 'grouped',
        groupSort: GroupSort.Desc,
        groupAlertBehavior: GroupAlertBehavior.Children,
        vibrationPattern: lowVibrationPattern,
        importance: NotificationImportance.High,
      ),
      NotificationChannel(
        channelGroupKey: 'layout_tests',
        icon: 'resource://drawable/res_download_icon',
        channelKey: 'progress_bar',
        channelName: 'Progress bar notifications',
        channelDescription: 'Notifications with a progress bar layout',
        vibrationPattern: lowVibrationPattern,
        onlyAlertOnce: true,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupkey: 'basic_tests',
        channelGroupName: 'Basic tests',
      ),
      NotificationChannelGroup(
        channelGroupkey: 'category_tests',
        channelGroupName: 'Category tests',
      ),
      NotificationChannelGroup(
        channelGroupkey: 'chat_tests',
        channelGroupName: 'Chat tests',
      ),
      NotificationChannelGroup(
        channelGroupkey: 'layout_tests',
        channelGroupName: 'Layout tests',
      ),
      NotificationChannelGroup(
        channelGroupkey: 'grouping_tests',
        channelGroupName: 'Grouping tests',
      ),
    ],
    debug: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(
        title: 'Awesome Notifications',
      ),
    );
  }
}
