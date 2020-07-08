import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(QuotesApp());

class QuotesApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: HomePageWidget()
   );
  }
  
}