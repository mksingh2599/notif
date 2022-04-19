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

Future<void> createMessagingNotification({
  required String channelKey,
  required String groupKey,
  required String chatName,
  required String username,
  required String message,
  String? largeIcon,
  bool checkPermission = true,
}) async {
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
      category: NotificationCategory.Message,
      body: 'Join BGMI tournament\n You just won our prize'
          '\n'
          'Start BGMI tournament\n Are you tired from false advertisements? '
          '\n'
          'Tournament is ready\n Stop to ignore me!'
          '\n'
          'READ MY MESSAGE\n Stop to ignore me!'
          '\n'
          'READ MY MESSAGE\n Stop to ignore me!'
          '\n'
          'READ MY MESSAGE\n Stop to ignore me!'
          '\n'
          'READ MY MESSAGE\n Stop to ignore me!'
          '\n'
          'READ MY MESSAGE\n Stop to ignore me!'
          '\n'
          'READ MY MESSAGE\n Stop to ignore me!'
          '\n'
          'READ MY MESSAGE\n Stop to ignore me!'
          '\n'
          'READ MY MESSAGE\n Stop to ignore me!'
          '\n'
          'Winner\n Stop to ignore me!'
          '\n'
          'Winner\n Stop to ignore me!'
          '\n'
          'Tournament Ends\n Stop to ignore me!',
      summary: 'Text messages',
      largeIcon: 'https://picsum.photos/200',
      notificationLayout: NotificationLayout.MessagingGroup,
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

Future<void> showGroupedNotifications(
    String channelKey, String groupKey) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: channelKey,
      groupKey: groupKey,
      notificationLayout: NotificationLayout.Messaging,
      category: NotificationCategory.Message,
      summary: 'Text messages',
      title: 'Little Jhonny',
      body: 'Hey dude! Look what i found!',
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

  sleep(const Duration(seconds: 2));

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 2,
      channelKey: channelKey,
      groupKey: groupKey,
      notificationLayout: NotificationLayout.Messaging,
      category: NotificationCategory.Message,
      summary: 'Text messages',
      title: 'Cyclano',
      body: 'What?',
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

  sleep(const Duration(seconds: 2));

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 3,
      channelKey: channelKey,
      groupKey: groupKey,
      notificationLayout: NotificationLayout.Messaging,
      category: NotificationCategory.Message,
      summary: 'Text messages',
      title: 'Little Jhonny',
      body: 'This push notifications plugin is amazing!',
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

  sleep(const Duration(seconds: 2));

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 4,
      channelKey: channelKey,
      groupKey: groupKey,
      notificationLayout: NotificationLayout.Messaging,
      category: NotificationCategory.Message,
      summary: 'Text messages',
      title: 'Little Jhonny',
      body: 'Its perfect!',
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

  sleep(const Duration(seconds: 2));

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 5,
      channelKey: channelKey,
      groupKey: groupKey,
      notificationLayout: NotificationLayout.Messaging,
      category: NotificationCategory.Message,
      summary: 'Text messages',
      title: 'Little Jhonny',
      body: 'I gonna contribute with the project! For sure!',
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

  sleep(const Duration(seconds: 2));
}

Future<void> showProgressNotification(int id) async {
  var totalTime = 10;
  for (var currentTime = 1; currentTime <= totalTime + 1; currentTime++) {
    await Future.delayed(
      const Duration(seconds: 1),
      () async {
        if (currentTime > totalTime) {
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: id,
              channelKey: 'progress_bar',
              title: 'Tournament Started',
              category: NotificationCategory.Progress,
              notificationLayout: NotificationLayout.BigPicture,
              locked: false,
              icon: 'resource://drawable/logo',
              bigPicture: 'asset://assets/notif.jpg',
            ),
          );
        } else {
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: id,
              channelKey: 'progress_bar',
              title: 'Tournaments starts in ${totalTime - currentTime} seconds',
              category: NotificationCategory.Progress,
              notificationLayout: NotificationLayout.BigPicture,
              progress: min((currentTime / totalTime * 100).round(), 100),
              locked: true,
              icon: 'resource://drawable/logo',
              bigPicture: 'asset://assets/notif.jpg',
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
