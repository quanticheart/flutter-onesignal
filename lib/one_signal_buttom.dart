import 'package:flutter/material.dart';

typedef OnButtonPressed = void Function();

class OneSignalButton extends StatefulWidget {
  final String title;
  final OnButtonPressed onPressed;
  final bool enabled;

  const OneSignalButton(this.title, this.onPressed, this.enabled, {super.key});

  @override
  State<StatefulWidget> createState() => OneSignalButtonState();
}

class OneSignalButtonState extends State<OneSignalButton> {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 212, 86, 83),
              disabledBackgroundColor: const Color.fromARGB(180, 212, 86, 83),
              padding: const EdgeInsets.all(8.0),
            ),
            onPressed: widget.enabled ? widget.onPressed : null,
            child: Text(widget.title),
          )
        ]),
        TableRow(children: [
          Container(
            height: 8.0,
          )
        ]),
      ],
    );
  }
}
