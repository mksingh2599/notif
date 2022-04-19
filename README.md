# notif

A POC for awesome_notifications plugin.

- Notification Channels must be initialized in main.dart for each type of notification, that is to be shown in the app.

- Notification Group must also be initialized for the notifications that are to be grouped together in a single notification tray.

- Notifications have id, which can be used to dismiss notifications programatically. Channel key can be used to get user action in notifications, such as reply, accept, reject etc. Group Key are used to group notifications together.

## Basic Notification with a big picture.

- A large picture is shown in the notification, it can be shown under title, in background or foreground.

## Call Notification

- Notifies for incoming call, plays default ringtone.
- can listen to user action for accept or reject and respond aptly for the action.

## Chat Notification

- shows user icon in circleavatar with username and text body under it.
- can mark as read or quick reply.
- can also add other actions.

## Group Chat Notification

- shows large text body with a title with reply and read action.

## Progress Notification

- shows progress for any task.
- currently used to show countdown to start of tournament,can also be used to show download, upload progress.

# Other notifications

## Alarm Notification

- plays alarm ringtone.
- can add user action to snooze etc.

## Indeterminate progress

- to show progress when complete data is unknown.

## Big Text Notification

- shows a large text
