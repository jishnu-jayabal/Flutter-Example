import 'package:TestTheme/themes/app_themes.dart';
import 'package:TestTheme/themes/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Preference extends StatelessWidget {
  const Preference({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preference"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: AppThemes.values.length,
          itemBuilder: (context , index){
            return Padding(
              padding: EdgeInsets.fromLTRB(10,5,10,5),
              child: Card(
                
                color: appThemes[AppThemes.values[index]].primaryColor,
                child: ListTile(title: Text(AppThemes.values[index].toString()),onTap: (){
                  BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(AppThemes.values[index]));
                },),
              ),
            );
          }
        )
      ),
    );
  }
}