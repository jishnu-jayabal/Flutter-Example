import 'package:TestTheme/pages/home.dart';
import 'package:TestTheme/pages/preference.dart';
import 'package:TestTheme/themes/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context)=>ThemeBloc(),
      child: BlocBuilder<ThemeBloc , ThemeState>(
        builder: (context, ThemeState themeState){
          return initMaterialApp(themeState);
        },
      ),
    );
  }

  Widget initMaterialApp(ThemeState themeState) {
    return MaterialApp(
          theme: themeState.themeData,
          routes: {
            "/": (context)=>Home(),
            "home": (context)=>Home(),
            "preference": (context)=>Preference()
          },
          title: 'Material App',

        );
  }
}