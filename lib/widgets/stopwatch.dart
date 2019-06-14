import 'package:flutter/material.dart';
import 'package:stopwatch/bloc/bloc.dart';
import 'package:stopwatch/widgets/widget.dart';

class Stopwatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TimerBloc _timerBloc = BlocProvider.of<TimerBloc>(context);

    return BlocBuilder(
      bloc: _timerBloc,
      builder: (BuildContext context, TimerState state) {
        final duration = state.duration;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Clock(
              seconds: duration,
            ),
            Action(
              state: state,
              timerBloc: _timerBloc,
            )
          ],
        );
      },
    );
  }
}
