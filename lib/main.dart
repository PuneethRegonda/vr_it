import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vr_it/ui/firebase_login.dart';
import 'package:vr_it/ui/bottom_option_app_intro.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  FirebaseAuth _auth = FirebaseAuth.instance;
  if (_auth.currentUser() != null) {
    runApp(MaterialApp(
      //user signed in
      home: BottomButtonsAppIntro(),
    ));
  } else {
    runApp(MaterialApp(
      //user not signed in
      home: FirebaseLogin(),
    ));
  }
}
