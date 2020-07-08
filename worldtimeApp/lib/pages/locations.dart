import 'package:flutter/material.dart';
import 'package:worldtimeApp/models/time_param.dart';
import 'package:worldtimeApp/services/time_service.dart';

class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  updateTime(index) async {
      TimeService tms = TimeService();
      String location = timezones[index].split("/")[1];
      await tms.getTime(TimeParam(location: location,url: timezones[index]));
      Navigator.pop(context,{"time": tms.time});
  }

  List<String> timezones = ["Asia/Kolkata" , "Europe/Berlin"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Locations"),
      ),
      body: ListView.builder(
        itemCount: timezones.length,
        itemBuilder: (context,index){
          return Card(child: ListTile(
            onTap: ()=> updateTime(index),
            title: Text(timezones[index]) ,
          ),);
        })
      );
  }
  
}