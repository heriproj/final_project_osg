import 'package:final_project_osg/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new MainMenu(),
        title: new Text('Recipes OSG 8 AlHanifdev',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              fontSize: 30.0
          ),),
        version: new Text('Final Project OSG 8 By Heri',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              fontSize: 15.0,
          ),),
        image: new Image.asset('assets/images/logocafe.png', fit: BoxFit.cover,),
        backgroundColor: Colors.indigo,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=>print("Flutter Egypt"),
        loaderColor: Colors.white70
    );

  }
}
