import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TimerEvent extends Equatable {
  TimerEvent([List props = const []]) : super(props);
}

class StartEvent extends TimerEvent {
  final int duration;
  StartEvent({@required this.duration}) : super([duration]);

  @override
  String toString() => "Start {duration: $duration}";
}

class PauseEvent extends TimerEvent {
  @override
  String toString() => "Pause";
}

class ResumeEvent extends TimerEvent {
  @override
  String toString() => "Resume";
}

class ResetEvent extends TimerEvent {
  @override
  String toString() => "Reset";
}

class TickEvent extends TimerEvent {
  final int duration;
  TickEvent({@required this.duration}) : super([duration]);

  @override
  String toString() => "Tick {duration: $duration}";
}
