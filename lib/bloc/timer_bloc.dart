import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stopwatch/bloc/timer_event.dart';
import 'package:stopwatch/ticker.dart';
import './bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  final int _duration = 60;

  StreamSubscription<int> _tickerSubcription;

  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  @override
  TimerState get initialState => ReadyState(_duration);

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is StartEvent) {
      //If your generator is recursive, you can improve its performance by using yield*
      //maybe it improve the performance of the async generator inside an async generor;
      yield* _mapStartToState(event);
    } else if (event is TickEvent) {
      yield* _mapTickToState(event);
    } else if (event is PauseEvent) {
      yield* _mapPauseToState(event);
    } else if (event is ResumeEvent) {
      yield* _mapResumeToState(event);
    } else if (event is ResetEvent) {
      yield* _mapResetToState(event);
    }
  }

  @override
  void dispose() {
    _tickerSubcription?.cancel();
    super.dispose();
  }

  Stream<TimerState> _mapStartToState(StartEvent start) async* {
    yield RunningState(start.duration);
    _tickerSubcription?.cancel();
    _tickerSubcription = _ticker.tick(ticks: start.duration).listen((duration) {
      dispatch(TickEvent(duration: duration)); //
    });
  }

  Stream<TimerState> _mapTickToState(TickEvent tick) async* {
    yield tick.duration > 0 ? RunningState(tick.duration) : FinishedState();
  }

  Stream<TimerState> _mapPauseToState(PauseEvent pause) async* {
    final state = currentState;
    if (state is RunningState) {
      _tickerSubcription?.pause();
      yield PausedState(state.duration);
    }
  }

  Stream<TimerState> _mapResumeToState(ResumeEvent resume) async* {
    final state = currentState;
    if (state is PausedState) {
      _tickerSubcription?.resume();
      // if state is PausedState which doesn't have duration, how state.duration work in here?
      // when _tickerSubcription running, it's dispatch 1 TickEvent every second,
      // so the currentState change(?) to TickEvent so state.duration work.
      yield RunningState(state.duration);
    }
  }

  Stream<TimerState> _mapResetToState(ResetEvent reset) async* {
    _tickerSubcription?.cancel();
    yield ReadyState(_duration);
  }
}
