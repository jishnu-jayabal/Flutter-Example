class CounterState {

  int _counter;

  set counter(value) => _counter = value;

  get counter => _counter;

  CounterState(CounterState counterState) { this._counter = counterState._counter;}

  CounterState._();

  factory CounterState.initial() {
    return CounterState._()
           ..counter = 0;
  }

  CounterState clone(CounterState state) => CounterState(state);

  @override
  String toString() {
    return "Counter String ${this._counter}";
  }

}