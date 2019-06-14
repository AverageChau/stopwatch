import 'package:flutter/material.dart';
import 'package:stopwatch/widgets/widget.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Stopwatch'),
        ),
        body: Stopwatch());
  }
}
