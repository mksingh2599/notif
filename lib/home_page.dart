import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notif/notif.dart';
import 'package:notif/phone_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    AwesomeNotifications().createdStream.listen((receivedNotification) {
      String? createdSourceText = AwesomeAssertUtils.toSimpleEnumString(
          receivedNotification.createdSource);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$createdSourceText notification created',
          ),
        ),
      );
    });

    AwesomeNotifications().displayedStream.listen((receivedNotification) {
      String? createdSourceText = AwesomeAssertUtils.toSimpleEnumString(
          receivedNotification.createdSource);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$createdSourceText notification displayed'),
        ),
      );
    });

    AwesomeNotifications().dismissedStream.listen((receivedAction) {
      String? dismissedSourceText = AwesomeAssertUtils.toSimpleEnumString(
          receivedAction.dismissedLifeCycle);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notification dismissed on $dismissedSourceText'),
        ),
      );
    });

    AwesomeNotifications().actionStream.listen((receivedAction) {
      if (receivedAction.channelKey == 'call_channel') {
        switch (receivedAction.buttonKeyPressed) {
          case 'REJECT':
            AndroidForegroundService.stopForeground();
            break;

          case 'ACCEPT':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PhoneCallPage(receivedAction: receivedAction),
              ),
            );
            AndroidForegroundService.stopForeground();
            break;

          default:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PhoneCallPage(receivedAction: receivedAction),
              ),
            );
            break;
        }
        return;
      }

      if (receivedAction.channelKey == 'alarm_channel') {
        AndroidForegroundService.stopForeground();
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const ElevatedButton(
                child: Text(
                  'Basic Notification',
                ),
                onPressed: createBasicBigPictureNotification,
              ),
              ElevatedButton(
                child: const Text(
                  'Call Notification',
                ),
                onPressed: () async {
                  await showCallNotification(1);
                },
              ),
              ElevatedButton(
                child: const Text(
                  'Alarm Notification',
                ),
                onPressed: () async {
                  await showAlarmNotification(2);
                },
              ),
              ElevatedButton(
                child: const Text(
                  'Chat Notification',
                ),
                onPressed: () async {
                  await simulateChatConversation(
                    groupKey: 'trangy_gaming',
                  );
                },
              ),
              ElevatedButton(
                child: const Text(
                  'Group chat Notification',
                ),
                onPressed: () async {
                  await showInboxNotification(10);
                },
              ),
              ElevatedButton(
                child: const Text(
                  'Grouped Notification',
                ),
                onPressed: () async {
                  await showGroupedNotifications('grouped', 'group_key');
                },
              ),
              ElevatedButton(
                child: const Text(
                  'Progress Notification',
                ),
                onPressed: () async {
                  await showProgressNotification(9);
                },
              ),
              ElevatedButton(
                child: const Text(
                  'Indeterminate Progress Notification',
                ),
                onPressed: () async {
                  await showIndeterminateProgressNotification(99);
                },
              ),
              ElevatedButton(
                child: const Text(
                  'Cancel Indeterminate Progress Notification',
                ),
                onPressed: () async {
                  await cancelNotification(99);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    AwesomeNotifications().createdSink.close();
    AwesomeNotifications().displayedSink.close();
    AwesomeNotifications().actionSink.close();
    super.dispose();
  }
}
