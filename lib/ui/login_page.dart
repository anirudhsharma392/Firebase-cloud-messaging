import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:human_resource/mobx/central_state.dart';
import 'package:human_resource/ui/home_page.dart';
import 'package:human_resource/ui/signup_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email;

  String _password;

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();


  void fetchToken(){
    firebaseMessaging.configure(
      onLaunch:(Map <String ,dynamic > msg){
        print("onLaunch called");

      },
      onResume: (Map <String ,dynamic > msg){
        print("onResume called");
      },

      onMessage: (Map <String ,dynamic > msg){
        print("onMessage called");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true,alert: true,badge: true)
    );
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings setting){
      print('ios setting registered');
    });
    firebaseMessaging.getToken().then(((token){print(token);}));

  }

  Widget build(BuildContext context) {
    fetchToken();
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 128.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,

      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      onChanged: (value) {
        setState(() {
          _password = value;
        });
      },
      autofocus: false,

      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password)
              .then((user) {
            Navigator.of(context).pushReplacementNamed("/homepage");
          }).catchError((e) {
            print(e);
          });
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Wanna SignUp?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed("/signuppage");
      },
    );



    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
