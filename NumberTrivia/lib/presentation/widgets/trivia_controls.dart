import 'package:NumberTrivia/presentation/bloc/numbertrivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaControls extends StatefulWidget {
  TriviaControls({Key key}) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {

  String numStr;

  final textController = TextEditingController();
  
  _TriviaControlsState({Key key});

  @override
  Widget build(BuildContext context) {
    return  Column(
                children: <Widget>[
                 TextField(
                   controller: textController,
                   keyboardType: TextInputType.number,
                   decoration: InputDecoration(border: OutlineInputBorder()),
                   onChanged: (value){this.numStr=value;},
                   onSubmitted: (_){this.dispatch(context);}
                 ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: (){dispatch(context);}, 
                          child: Text("Search",),
                          color: Theme.of(context).accentColor,
                          textTheme: ButtonTextTheme.primary,
                        )
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RaisedButton(
                          onPressed: (){dispatchRandom(context);}, 
                          child: Text("Get Random Trivia",)
                        )
                      )
                    ],
                  )
                ],
              );
  }

  void dispatch(context) {
    textController.clear();
    BlocProvider.of<NumbertriviaBloc>(context)
    .add(GetConcreteNumberTriviaEvent(this.numStr));
  }

  void dispatchRandom(context) {
    BlocProvider.of<NumbertriviaBloc>(context)
    .add(GetRandomNumberTriviaEvent());
  }
}