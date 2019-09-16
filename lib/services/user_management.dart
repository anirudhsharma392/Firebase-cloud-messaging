import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:human_resource/ui/home_page.dart';

class UserManagement {
  static storeNewUser(context) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    Firestore.instance
        .collection('/users')
        .add({'email': user.email, 'uid': user.uid}).then((value) {
      print('sign up done');
    }).catchError((error) {
      print('error occured');
      print(error);
    });
  }
}
