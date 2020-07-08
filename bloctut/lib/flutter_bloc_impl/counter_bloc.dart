import 'package:bloctut/flutter_bloc_impl/counter_event.dart';
import 'package:bloctut/flutter_bloc_impl/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CounterBloc extends Bloc<CounterEvent , CounterState>{

  CounterBloc() : super(CounterState.initial());

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    final newState = state.clone(state);
    if(event is CounterIncremenetEvent) {
      yield newState..counter += 1;
      print(state);
    } else {
       yield newState..counter -= 1;
    }
  }

  onIncrement() {
    this.add(CounterIncremenetEvent());
  }

  onDecrement() {
    this.add(CounterDecrementEvent());
  }
  


}