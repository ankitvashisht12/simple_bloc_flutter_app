import 'dart:async';
import 'event_counter.dart';

abstract class BLOC {
  void dispose() {}
}

class CounterBloc extends BLOC {
  // define state
  int _counter = 0;

  // streamController, Sink and stream for STATE
  StreamController<int> _counterStateController = StreamController<int>();

  StreamSink<int> get _counterSink => _counterStateController.sink;
  Stream<int> get counterStream => _counterStateController.stream;

  // streamController, Sink for Event
  StreamController<CounterEvent> _counterEventController =
      StreamController<CounterEvent>();

  StreamSink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapToState);
  }

  void _mapToState(CounterEvent event) {
    if (event is Increment)
      _counter++;
    else
      _counter--;

    _counterSink.add(_counter);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _counterStateController.close();
    _counterEventController.close();
  }
}
