import 'dart:io';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notif/utils.dart';

Future<void> createBasicBigPictureNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().millisecond,
      channelKey: 'basic_channel',
      title: '${Emojis.money_money_bag + Emojis.plant_cactus} New Tournament',
      body: 'Get ready to take part in the new BGMI tournament',
      bigPicture: 'https://picsum.photos/200/500',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

Future<void> createTimerNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 2,
      channelKey: 'timer_notification',
      title: 'Friendly Reminder ${Emojis.smile_slightly_smiling_face}',
      body: 'timeEllapsed',
      notificationLayout: NotificationLayout.Default,
      displayOnBackground: false,
      displayOnForeground: false,
      autoDismissible: false,
      wakeUpScreen: false,
      category: NotificationCategory.StopWatch,
    ),
  );
}

Future<void> showCallNotification(int id) async {
  String platformVersion = await getPlatformVersion();
  // AndroidForegroundService.startForeground(
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'call_channel',
      title: 'Incoming Call',
      body: 'from Tf_09',
      category: NotificationCategory.Call,
      largeIcon: 'https://picsum.photos/200',
      wakeUpScreen: true,
      fullScreenIntent: true,
      autoDismissible: false,
      backgroundColor: (platformVersion == 'Android-31')
          ? const Color(0x0000796a)
          : Colors.white,
      payload: {'username': 'Tf_09'},
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'ACCEPT',
        label: 'Accept Call',
        color: Colors.green,
        autoDismissible: true,
      ),
      NotificationActionButton(
        key: 'REJECT',
        label: 'Reject',
        isDangerousOption: true,
        autoDismissible: true,
      ),
    ],
  );
}

Future<void> showAlarmNotification(int id) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'alarm_channel',
      title: 'Alarm is playing',
      body: 'Hey! Wake Up!',
      category: NotificationCategory.Alarm,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'SNOOZE',
        label: 'Snooze for 5 minutes',
        color: Colors.blue,
        autoDismissible: true,
      ),
    ],
  );
}

int _messageIncrement = 0;
Future<void> simulateChatConversation({required String groupKey}) async {
  _messageIncrement++ % 4 < 2
      ? createMessagingNotification(
          channelKey: 'chats',
          groupKey: groupKey,
          chatName: 'Trangy Gaming',
          username: 'Tf_09',
          largeIcon: 'https://picsum.photos/200/500',
          message: 'BGMI tournament $_messageIncrement',
        )
      : createMessagingNotification(
          channelKey: 'chats',
          groupKey: groupKey,
          chatName: 'Tf Group',
          username: 'Noob',
          largeIcon: 'https://picsum.photos/200/500',
          message: 'CODM tournament $_messageIncrement',
        );
}

Future<void> simulateSendResponseChatConversation({
  required String msg,
  required String groupKey,
}) async {
  createMessagingNotification(
    channelKey: 'chats',
    groupKey: groupKey,
    chatName: 'Tf Group',
    username: 'you',
    largeIcon: 'https://picsum.photos/200/500',
    message: msg,
  );
}

Future<void> createMessagingNotification(
    {required String channelKey,
    required String groupKey,
    required String chatName,
    required String username,
    required String message,
    String? largeIcon,
    bool checkPermission = true}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: Random().nextInt(AwesomeNotifications.maxID),
      groupKey: groupKey,
      channelKey: channelKey,
      summary: chatName,
      title: username,
      body: message,
      largeIcon: largeIcon,
      notificationLayout: NotificationLayout.Messaging,
      category: NotificationCategory.Message,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'REPLY',
        label: 'Reply',
        buttonType: ActionButtonType.InputField,
        autoDismissible: true,
      ),
      NotificationActionButton(
        key: 'READ',
        label: 'Mark as Read',
        autoDismissible: true,
      )
    ],
  );
}

Future<void> showInboxNotification(int id) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: "inbox",
      title: '5 New messages from Tf_09',
      category: NotificationCategory.Email,
      body: '<b>Join BGMI tournament</b> You just won our prize'
          '\n'
          '<b>Start BGMI tournament</b> Are you tired from false advertisements? '
          '\n'
          '<b>Tournament is ready</b> Stop to ignore me!'
          '\n'
          '<b>READ MY MESSAGE</b> Stop to ignore me!'
          '\n'
          '<b>READ MY MESSAGE</b> Stop to ignore me!'
          '\n'
          '<b>READ MY MESSAGE</b> Stop to ignore me!'
          '\n'
          '<b>READ MY MESSAGE</b> Stop to ignore me!'
          '\n'
          '<b>READ MY MESSAGE</b> Stop to ignore me!'
          '\n'
          '<b>READ MY MESSAGE</b> Stop to ignore me!'
          '\n'
          '<b>READ MY MESSAGE</b> Stop to ignore me!'
          '\n'
          '<b>READ MY MESSAGE</b> Stop to ignore me!'
          '\n'
          '<b>Winner</b> Stop to ignore me!'
          '\n'
          '<b>Winner</b> Stop to ignore me!'
          '\n'
          '<b>Tournament Ends</b> Stop to ignore me!',
      summary: 'E-mail inbox',
      largeIcon: 'https://picsum.photos/200',
      notificationLayout: NotificationLayout.Inbox,
      payload: {'uuid': 'uuid-test'},
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'DISMISS',
        label: 'Dismiss',
        buttonType: ActionButtonType.DisabledAction,
        autoDismissible: true,
        icon: 'resource://drawable/res_ic_close',
      ),
      NotificationActionButton(
        key: 'READ',
        label: 'Mark as read',
        autoDismissible: true,
      )
    ],
  );
}

Future<void> showGroupedNotifications(String channelKey) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: channelKey,
          title: 'Little Jhonny',
          body: 'Hey dude! Look what i found!'));

  sleep(const Duration(seconds: 2));

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 2, channelKey: 'grouped', title: 'Cyclano', body: 'What?'));

  sleep(const Duration(seconds: 2));

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 3,
          channelKey: channelKey,
          title: 'Little Jhonny',
          body: 'This push notifications plugin is amazing!'));

  sleep(const Duration(seconds: 2));

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 4,
          channelKey: channelKey,
          title: 'Little Jhonny',
          body: 'Its perfect!'));

  sleep(const Duration(seconds: 2));

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 5,
        channelKey: channelKey,
        title: 'Little Jhonny',
        body: 'I gonna contribute with the project! For sure!'),
  );
}

Future<void> showProgressNotification(int id) async {
  var maxStep = 10;
  for (var simulatedStep = 1; simulatedStep <= maxStep + 1; simulatedStep++) {
    await Future.delayed(
      const Duration(seconds: 1),
      () async {
        if (simulatedStep > maxStep) {
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: id,
              channelKey: 'progress_bar',
              title: 'Download finished',
              body: 'filename.txt',
              category: NotificationCategory.Progress,
              payload: {
                'file': 'filename.txt',
              },
              locked: false,
              icon: 'resource://drawable/logo',
            ),
          );
        } else {
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: id,
              channelKey: 'progress_bar',
              title:
                  'Downloading fake file in progress ($simulatedStep of $maxStep)',
              body: 'filename.txt',
              category: NotificationCategory.Progress,
              payload: {
                'file': 'filename.txt',
              },
              notificationLayout: NotificationLayout.ProgressBar,
              progress: min((simulatedStep / maxStep * 100).round(), 100),
              locked: true,
              icon: 'resource://drawable/logo',
            ),
          );
        }
      },
    );
  }
}

Future<void> showIndeterminateProgressNotification(int id) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'progress_bar',
      title: 'Downloading fake file...',
      body: 'filename.txt',
      category: NotificationCategory.Progress,
      payload: {
        'file': 'filename.txt',
        'path': '-rmdir c://ruwindows/system32/huehuehue'
      },
      notificationLayout: NotificationLayout.ProgressBar,
      progress: null,
      locked: true,
      icon: 'resource://drawable/logo',
    ),
  );
}

Future<void> cancelNotification(int id) async {
  await AwesomeNotifications().cancel(id);
}
