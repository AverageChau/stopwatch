import 'package:flutter/material.dart';
import 'package:stopwatch/bloc/bloc.dart';
import 'package:stopwatch/widgets/widget.dart';

class Stopwatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TimerBloc _timerBloc = BlocProvider.of<TimerBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        BlocBuilder(
          bloc: _timerBloc,
          builder: (BuildContext context, TimerState state) {
            return Container(
              // color: randomColor(),
              child: Clock(
                seconds: state.duration,
              ),
            );
          },
        ),
        BlocBuilder(
          condition: (previousState, currentState) =>
              currentState.runtimeType != previousState.runtimeType,
          bloc: _timerBloc,
          builder: (BuildContext context, TimerState state) {
            return Container(
              // color: randomColor(),
              child: Action(),
            );
          },
        )
      ],
    );
  }
}
