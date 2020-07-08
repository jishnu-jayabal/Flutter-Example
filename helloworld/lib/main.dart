import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: HelloWorldApp()));

class HelloWorldApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfilePage();
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int points = 0;

  List<String> degrees = ["BBA" , "BCA" , "BBMQ"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            points += 1;
          });
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                  backgroundImage: AssetImage("assets/one.jpg"),
                  radius: 100.0,
                )
            ),
            Divider(height: 30.0,),
            Column(
              children:[
                Text(
                  "JishnuJ",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "IndieFlower",
                  )
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(Icons.mail , color: Colors.redAccent,),
                    ),
                    Text(
                      "jishnujayabal@gmail.com",
                       style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "IndieFlower",
                      )
                    ),
                    SizedBox(height: 80,),
                  ],
                ),
                Text(
                  "$points",
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 120.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "IndieFlower",
                  )
                ),
                Text(
                  "Points",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "IndieFlower",
                    color: Colors.orangeAccent
                  ),
                )
              ]
            ),
            Column(
              children: degrees.map((e) => Text(
                  e,
                  style: TextStyle(color: Colors.amber,fontSize: 10),
                )
              ).toList()
            )
          ],
        ),
      ),
    );
  }
}
