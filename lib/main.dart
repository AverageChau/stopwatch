import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/bloc/bloc.dart';
import 'package:stopwatch/ticker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

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

class Stopwatch extends StatefulWidget {
  Stopwatch({Key key}) : super(key: key);

  _StopwatchState createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  static final Ticker _tick = Ticker();
  final TimerBloc _timerBloc = TimerBloc(ticker: _tick);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _timerBloc,
      builder: (BuildContext context, TimerState state) {
        final duration = state.duration;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              (duration ~/ 60).toString().padLeft(2, '0') +
                  ":" +
                  (duration % 60).toString().padLeft(2, '0'),
              style: TextStyle(fontSize: 50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                state is ReadyState || state is PausedState
                    ? FloatingActionButton(
                        child: Icon(Icons.play_arrow),
                        onPressed: () {
                          _timerBloc.dispatch(
                              state is ReadyState ? StartEvent(duration: duration) : ResumeEvent());
                        },
                      )
                    : state is RunningState
                        ? FloatingActionButton(
                            child: Icon(Icons.pause),
                            onPressed: () {
                              _timerBloc.dispatch(PauseEvent());
                            },
                          )
                        : Container(),
                FloatingActionButton(
                  child: Icon(Icons.autorenew),
                  onPressed: () {
                    _timerBloc.dispatch(ResetEvent());
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timerBloc.dispose();
    super.dispose();
  }
}
