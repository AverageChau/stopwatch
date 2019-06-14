import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/bloc.dart';
import 'package:stopwatch/screens/screens.dart';
import 'package:stopwatch/ticker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TimerBloc _timerBloc = TimerBloc(ticker: Ticker());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          bloc: _timerBloc,
          child: MyHomePage(),
        ));
  }

  @override
  void dispose() {
    _timerBloc.dispose();
    super.dispose();
  }
}
