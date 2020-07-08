import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              Navigator.pushNamed(context, "preference");
            },
          )
        ],
        
      ),
      body: Container(
        child: Center(
          child: Text(
            "Home",
            style: TextStyle(fontSize: 40),
          )
        )
      ),
    );
  }
}