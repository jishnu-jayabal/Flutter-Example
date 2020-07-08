import 'package:flutter/material.dart';
import 'quote.dart';

class QuoteCardWidget extends StatelessWidget {

  final Quote quote;
  final Function delete;

  QuoteCardWidget({this.quote,this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(15.0, 7.5, 15.0, 7.5),
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  quote.getText,
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(
                  quote.author,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "IndieFlower",
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete), 
                    onPressed: (){this.delete();}
                  )
                ],
              )
            ])));
  }
}
