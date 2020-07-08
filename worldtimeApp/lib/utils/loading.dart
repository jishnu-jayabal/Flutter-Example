import 'package:flutter/material.dart';
import 'package:worldtimeApp/models/time_param.dart';
import 'package:worldtimeApp/services/time_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  void setUpWorldTime() async {
    TimeService tms = TimeService();
    await tms.getTime(TimeParam(url: "Europe/Berlin"));
    Navigator.pushReplacementNamed(context, "/home",
        arguments: {"time": tms.time});
  }

  @override
  void initState() {
    super.initState();
    this.setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitCubeGrid(
        color: Colors.white,
        size: 50.0,
      ),
      ),
    );
  }
}
