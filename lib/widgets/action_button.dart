import 'package:flutter/material.dart';
import 'package:stopwatch/bloc/bloc.dart';
import 'package:stopwatch/bloc/timer_bloc.dart';

class Action extends StatelessWidget {
  final TimerState state;
  final TimerBloc timerBloc;

  const Action({this.state, this.timerBloc, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        state is ReadyState || state is PausedState
            ? FloatingActionButton(
                child: Icon(Icons.play_arrow),
                onPressed: () {
                  timerBloc.dispatch(
                      state is ReadyState ? StartEvent(duration: state.duration) : ResumeEvent());
                },
              )
            : state is RunningState
                ? FloatingActionButton(
                    child: Icon(Icons.pause),
                    onPressed: () {
                      timerBloc.dispatch(PauseEvent());
                    },
                  )
                : Container(),
        FloatingActionButton(
          child: Icon(Icons.autorenew),
          onPressed: () {
            timerBloc.dispatch(ResetEvent());
          },
        )
      ],
    );
  }
}
