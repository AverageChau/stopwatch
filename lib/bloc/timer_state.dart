import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TimerState extends Equatable {
  final int duration;

  TimerState(this.duration, [List props = const []]) : super([duration]..addAll(props));
}

class ReadyState extends TimerState {
  ReadyState(int duration) : super(duration);

  @override
  String toString() => 'Ready {duration: $duration}';
}

class RunningState extends TimerState {
  RunningState(int duration) : super(duration);

  @override
  String toString() => 'Running {duration: $duration}';
}

class PausedState extends TimerState {
  PausedState(int duration) : super(duration);

  @override
  String toString() => 'Paused {duration: $duration}';
}

class FinishedState extends TimerState {
  FinishedState() : super(0); // duration = 0 because the countdown is complete.

  @override
  String toString() => 'Finished {duration: $duration}';
}
