import 'package:NumberTrivia/injection_container.dart';
import 'package:NumberTrivia/presentation/screen/number_trivia_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: NumberTriviaScreen()
   );
  }

}