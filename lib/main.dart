import 'package:flutter/material.dart';
import 'package:human_resource/ui/home_page.dart';
import 'package:human_resource/ui/login_page.dart';
import 'package:human_resource/ui/signup_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{

    "/homepage":(context) => HomePage(),
    "/signuppage":(context) => SignupPage(),
    "/loginpage":(context)=>LoginPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}