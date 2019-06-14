import 'package:flutter/material.dart';

class Clock extends StatelessWidget {
  final int seconds;
  const Clock({this.seconds, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      (seconds ~/ 60).toString().padLeft(2, '0') + ":" + (seconds % 60).toString().padLeft(2, '0'),
      style: TextStyle(fontSize: 50),
    );
  }
}
