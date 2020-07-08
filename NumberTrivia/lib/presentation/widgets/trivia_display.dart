
import 'package:NumberTrivia/domain/entities/number_trivia.dart';
import 'package:flutter/material.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia numberTrivaia;

  const TriviaDisplay({Key key, @required this.numberTrivaia})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                numberTrivaia.number.toString(),
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Text(
                    numberTrivaia.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
