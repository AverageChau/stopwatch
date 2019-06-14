import 'package:flutter/material.dart';
import 'package:stopwatch/bloc/bloc.dart';
import 'package:stopwatch/bloc/timer_bloc.dart';

class Action extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _mapStateToActionButtons(timerBloc: BlocProvider.of<TimerBloc>(context)));
  }

  List<Widget> _mapStateToActionButtons({TimerBloc timerBloc}) {
    final TimerState state = timerBloc.currentState;
    if (state is ReadyState) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {
            timerBloc.dispatch(StartEvent(duration: state.duration));
          },
        )
      ];
    }
    if (state is RunningState) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () {
            timerBloc.dispatch(PauseEvent());
          },
        ),
        FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            timerBloc.dispatch(ResetEvent());
          },
        )
      ];
    }
    if (state is PausedState) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_circle_outline),
          onPressed: () {
            timerBloc.dispatch(ResumeEvent());
          },
        ),
        FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            timerBloc.dispatch(ResetEvent());
          },
        )
      ];
    }
    if (state is FinishedState) {
      return [
        FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            timerBloc.dispatch(ResetEvent());
          },
        )
      ];
    }
    return [];
  }
}
