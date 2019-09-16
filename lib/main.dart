import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:human_resource/ui/home_page.dart';
import 'package:human_resource/ui/login_page.dart';
import 'package:human_resource/ui/signup_page.dart';

import 'mobx/central_state.dart';

bool loggedIn = false;

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FirebaseAuth.instance.currentUser().then((user) {
    if (user != null) {
      centralstate.user =user;
      centralstate.uid = user.uid;
      loggedIn = true;
      print('user exists');
    } else {
      print('user does not  exists');
      loggedIn = false;
    }
  });
  runApp(DisplayLogo());
}

class DisplayLogo extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<DisplayLogo> {
  initState() {
    Timer(Duration(seconds: 2), () {
      runApp(MyApp());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: FlutterLogo(size: 300),
        ));
  }
}
class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    "/homepage": (context) => HomePage(),
    "/signuppage": (context) => SignupPage(),
    "/loginpage": (context) => LoginPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: loggedIn ? HomePage() : LoginPage(),
      routes: routes,
    );
  }
}
