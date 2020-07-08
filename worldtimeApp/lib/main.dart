import 'package:flutter/material.dart';
import 'package:worldtimeApp/pages/home.dart';
import 'package:worldtimeApp/pages/locations.dart';
import 'package:worldtimeApp/utils/loading.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/",
  routes:{
    "/": (context) => LoadingWidget(),
    "/home": (context) => HomePage(),
    "location": (context) => LocationPage()
  },
));
