import 'package:flutter/material.dart';
import 'package:worldtimeApp/models/time.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Time time;

  void getArguments() {
    Map arguments = ModalRoute.of(context).settings.arguments;
    time = time != null ? time : arguments['time'];
  }

  @override
  Widget build(BuildContext context) {
    getArguments();

    return Scaffold(
      backgroundColor: Colors.blue[800],
        appBar: AppBar(title: Text("Home"),backgroundColor: Colors.blue[600],elevation: 0,),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            dynamic data = await Navigator.pushNamed(context, "location");
            setState(() {
              time = data["time"];
              print(time.location);
            });
          },
          child: Icon(Icons.edit_location),
        ),
        body: Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage("assets/images/day.png"),fit: BoxFit.cover,),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(time.location,
                      style: TextStyle(
                          fontSize: 50.0, color: Colors.orangeAccent)),
                  Text(
                    time.time,
                    style: TextStyle(fontSize: 50.0),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
