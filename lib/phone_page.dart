import 'dart:async';

import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notif/slider.dart';

class PhoneCallPage extends StatefulWidget {
  final ReceivedAction receivedAction;

  const PhoneCallPage({Key? key, required this.receivedAction})
      : super(key: key);

  @override
  State<PhoneCallPage> createState() => _PhoneCallPageState();
}

class _PhoneCallPageState extends State<PhoneCallPage> {
  Timer? _timer;
  Duration _secondsElapsed = Duration.zero;

  void startCallingTimer() {
    const oneSec = Duration(seconds: 1);
    AndroidForegroundService.stopForeground();

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          _secondsElapsed += oneSec;
        });
      },
    );
  }

  void finishCall() {
    AndroidForegroundService.stopForeground();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.receivedAction.buttonKeyPressed == 'ACCEPT') startCallingTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    AndroidForegroundService.stopForeground();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    ThemeData themeData = Theme.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image
          Image(
            image: widget.receivedAction.largeIconImage!,
            fit: BoxFit.cover,
          ),
          // Black Layer
          const DecoratedBox(
            decoration: BoxDecoration(color: Colors.black45),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.receivedAction.payload?['username']
                            ?.replaceAll(r'\s+', r'\n') ??
                        'Unknow',
                    maxLines: 4,
                    style: themeData.textTheme.headline3
                        ?.copyWith(color: Colors.white),
                  ),
                  Text(
                    _timer == null
                        ? 'Incoming call'
                        : 'Call in progress: ${printDuration(_secondsElapsed)}',
                    style: themeData.textTheme.headline6?.copyWith(
                        color: Colors.white54,
                        fontSize: _timer == null ? 20 : 12),
                  ),
                  const SizedBox(height: 50),
                  _timer == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white12),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(FontAwesomeIcons.solidClock,
                                        color: Colors.white54),
                                    Text('Reminder me',
                                        style: themeData.textTheme.headline6
                                            ?.copyWith(
                                                color: Colors.white54,
                                                fontSize: 12,
                                                height: 2))
                                  ],
                                )),
                            const SizedBox(),
                            TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Colors.white12),
                              ),
                              child: Column(
                                children: [
                                  const Icon(FontAwesomeIcons.solidEnvelope,
                                      color: Colors.white54),
                                  Text('Message',
                                      style: themeData.textTheme.headline6
                                          ?.copyWith(
                                              color: Colors.white54,
                                              fontSize: 12,
                                              height: 2))
                                ],
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _timer == null
                          ? [
                              RoundedButton(
                                press: finishCall,
                                color: Colors.red,
                                icon: const Icon(
                                  FontAwesomeIcons.phoneFlip,
                                  color: Colors.white,
                                ),
                              ),
                              SingleSliderToConfirm(
                                onConfirmation: () {
                                  startCallingTimer();
                                },
                                width: mediaQueryData.size.width * 0.55,
                                backgroundColor: Colors.white60,
                                text: 'Slide to Talk',
                                stickToEnd: true,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontSize:
                                            mediaQueryData.size.width * 0.05),
                                sliderButtonContent: RoundedButton(
                                  press: () {},
                                  color: Colors.white,
                                  icon: const Icon(FontAwesomeIcons.phoneFlip,
                                      color: Colors.green),
                                ),
                              )
                            ]
                          : [
                              RoundedButton(
                                press: () {},
                                icon: const Icon(FontAwesomeIcons.microphone),
                              ),
                              RoundedButton(
                                press: finishCall,
                                color: Colors.red,
                                icon: const Icon(FontAwesomeIcons.phoneFlip,
                                    color: Colors.white),
                              ),
                              RoundedButton(
                                press: () {},
                                icon: const Icon(FontAwesomeIcons.volumeHigh),
                              ),
                            ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.size = 64,
    required this.icon,
    this.color = Colors.white,
    required this.press,
  }) : super(key: key);

  final double size;
  final Icon icon;
  final Color color;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: TextButton(
        style: TextButton.styleFrom(
          primary: color,
          padding: EdgeInsets.all(15 / 64 * size),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ),
        onPressed: press,
        child: icon,
      ),
    );
  }
}

String printDuration(Duration? duration) {
  if (duration == null) return '00:00';
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}
