
import 'package:flutter/material.dart';
// import 'package:bloctut/counter_bloc.dart';
// import 'package:bloctut/counter_event.dart';
import 'package:bloctut/flutter_bloc_impl/counter_bloc.dart';
// import 'package:bloctut/flutter_bloc_impl/counter_event.dart';
// import 'package:bloctut/flutter_bloc_impl/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}


// class BlocPatternPureWxample extends StatelessWidget{

//  final _counterBloc = CounterBloc();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BloC  Using Pure Dart'),
//       ),
//       body: StreamBuilder(
//         stream: _counterBloc.counter,
//         builder: (context , AsyncSnapshot<int> snapshot){
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   'You have pushed the button this many times:',
//                 ),
//                 Text(
//                   snapshot.toString(),
//                   style: Theme.of(context).textTheme.headline4,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           FloatingActionButton(
//             onPressed: () => _counterBloc.inCounterEvent.add(CounterIncremenetEvent()),
//             tooltip: 'Increment',
//             child: Icon(Icons.add),
//           ),
//           SizedBox(
//             width: 10.0,
//           ),
//           FloatingActionButton(
//             onPressed: () => _counterBloc.inCounterEvent.add(CounterDecrementEvent()),
//             tooltip: 'Decrement',
//             child: Icon(Icons.remove),
//           ),
//         ],
//       ),
//     );
//   }
  
// }

class MyHomePage extends StatelessWidget {
  
  final _counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BloC Pattern Using Library'),
      ),
      body: BlocBuilder(
        bloc: _counterBloc,
        builder: (context , state){
          print("Inside Bloc Builder" + state.toString());
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  "${state.toString()}",
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => _counterBloc.onIncrement(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 10.0,
          ),
          FloatingActionButton(
            onPressed: () => _counterBloc.onDecrement(),
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
  
}

