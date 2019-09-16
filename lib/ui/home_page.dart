import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource/mobx/central_state.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:human_resource/services/crud.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final alucard = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 42.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/logo.png'),
        ),
      ),
    );

    final welcome = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Welcome !',
          style: TextStyle(fontSize: 28.0, color: Colors.white),
        ));

    final leaveApplication = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'leave Application',
          style: TextStyle(fontSize: 23.0, color: Colors.white),
        ));
    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Logout(),
              alucard,
              welcome,
              SizedBox(height: 24.0),
              leaveApplication,
              FormFieldss()
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}

class FormFieldss extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        SizedBox(height: 10.0),
        Name(),
        SizedBox(height: 14.0),
        ReasonField(),
        SizedBox(height: 14.0),
        datePicker(),
        Button()
      ],
    );
  }
}
class Logout extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Want to Sign out ?"),

            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Yes"),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, "/loginpage");

                },
              ),
              FlatButton(
                child: new Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return Row(mainAxisAlignment:MainAxisAlignment.end,children: <Widget>[
      InkWell(
        onTap: (){_showDialog();},
        child: Icon(
          Icons.power_settings_new,
          color: Colors.white,
          size: 30.0,
        ),
      )
    ],);
  }
}


final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

class Name extends StatefulWidget {
  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey1,
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'TextField is empty';
          } else if (value.length < 5) {
            return 'Name is too short';
          }
          return null;
        },
        style: TextStyle(color: Colors.white),
        showCursor: true,
        onChanged: (value) {
          setState(() {
            centralstate.name = value;
          });
        },
        autofocus: false,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          hintText: 'Full Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white70,
              ),
              borderRadius: BorderRadius.circular(32.0)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }
}

final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

class ReasonField extends StatefulWidget {
  @override
  _ReasonFieldState createState() => _ReasonFieldState();
}

class _ReasonFieldState extends State<ReasonField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey2,
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'TextField is empty';
          } else if (value.length < 5) {
            return 'Reason is too short';
          }
          return null;
        },
        style: TextStyle(color: Colors.white),
        showCursor: true,
        onChanged: (value) {
          setState(() {
            centralstate.reason = value;
          });
        },
        autofocus: false,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          hintText: 'Reason for a leave',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white70,
              ),
              borderRadius: BorderRadius.circular(32.0)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }
}

class datePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return FlatButton(
          onPressed: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(2019, 1, 1),
                maxTime: DateTime(2019, 12, 31), onChanged: (date) {
              String temp;
              temp = date.toString();
              centralstate.date = temp.substring(0, 10);
            }, onConfirm: (date) {
              String temp;
              temp = date.toString();
              centralstate.date = temp.substring(0, 10);
            }, currentTime: DateTime.now(), locale: LocaleType.en);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.all(12),
              color: Colors.lightBlueAccent,
              child: centralstate.date == ""
                  ? Text('Click here to choose Date',
                      style: TextStyle(fontSize: 20, color: Colors.white))
                  : Text('${centralstate.date}',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ));
    });
  }
}

class Button extends StatelessWidget {
  void request() {
    crudObject.addData('leaves', {
      "duration": centralstate.date,
      "name": centralstate.name,
      "reason": centralstate.reason
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            if (centralstate.date == "") {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Please provide the date')));
            } else if (formKey1.currentState.validate() &&
                formKey2.currentState.validate()) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Sending request')));
              request();

              ///call here

            }
          },
          padding: EdgeInsets.all(12),
          color: Colors.lightBlueAccent,
          splashColor: Colors.white,
          child:
              Text('Apply for a leave', style: TextStyle(color: Colors.white)),
        ),
      );
    });
  }
}
