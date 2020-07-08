import 'dart:async';

import 'package:bloctut/counter_event.dart';

class CounterBloc {

  int _counter  = 0;

  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get inCounterEvent => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen((event){
        if(event is CounterIncremenetEvent ) {
          _counter++;
        } else {
          _counter--;
        }

        _inCounter.add(_counter);
    });
  }


  void dispose() {
    _inCounter.close();
    _counterEventController.close();
    _counterStateController.close();
    inCounterEvent.close();
  }

}