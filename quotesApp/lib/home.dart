import 'package:flutter/material.dart';
import 'package:quotesApp/quote_card.dart';
import 'quote.dart';

class HomePageWidget extends StatefulWidget {
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {

  List<Quote> quotes = [
    Quote(author: "jishnu" , text: "sjsjhsjhsjsjhjshjshjhs"),
    Quote(author: "akhil" , text: "sjsjhsjhsjsjhjshjshjhs"),
    Quote(author: "adharsh" , text: "sjsjhsjhsjsjhjshjshjhs"),
    Quote(author: "jose" , text: "sjsjhsjhsjsjhjshjshjhs")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,  
        title: Text("Awseome Quotes")
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: quotes.map((quote) => QuoteCardWidget(
            quote: quote,
            delete: (){
              setState(() {
                this.quotes.remove(quote);
              });
            },
          )).toList()
        )
      ),
    );
  }

}