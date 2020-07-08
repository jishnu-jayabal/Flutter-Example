
import 'package:NumberTrivia/injection_container.dart';
import 'package:NumberTrivia/presentation/bloc/numbertrivia_bloc.dart';
import 'package:NumberTrivia/presentation/widgets/loading_indicator.dart';
import 'package:NumberTrivia/presentation/widgets/message_display.dart';
import 'package:NumberTrivia/presentation/widgets/trivia_controls.dart';
import 'package:NumberTrivia/presentation/widgets/trivia_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberTriviaScreen extends StatelessWidget {
  const NumberTriviaScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl.allReady(),
      builder: (context, snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Number Trivia"),
            ),
            body:SingleChildScrollView(
              child:  buildBody(context)),
            );
      },
    );
  }

  BlocProvider<NumbertriviaBloc> buildBody(BuildContext context) {
    return BlocProvider<NumbertriviaBloc>(
        create: (BuildContext context) => sl<NumbertriviaBloc>(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              BlocBuilder<NumbertriviaBloc, NumbertriviaState>(
                  builder: (context, state) {
                if (state is NumbertriviaInitial) {
                  return MessageDisplay(
                    message: "Start Searching",
                  );
                } else if (state is Loading) {
                  return LoadingIndicator();
                } else if (state is Loaded) {
                  return TriviaDisplay(numberTrivaia: state.numberTrivia,);
                } else if (state is Error) {
                  return MessageDisplay(
                    message: state.msg,
                  );
                }
              }),
              SizedBox(
                height: 20,
              ),
              TriviaControls(),
            ],
          ),
        ));
  }
}

