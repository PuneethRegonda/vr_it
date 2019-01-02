import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vr_it/ui/firebase_login.dart';
import 'package:vr_it/ui/bottom_option_app_intro.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  FirebaseAuth _auth = FirebaseAuth.instance;
  runApp(MaterialApp(
    //user signed in
    title: 'VR IT Groups',
    home: _auth.currentUser() != null
        ? BottomButtonsAppIntro()
        : FirebaseLogin(),
    debugShowCheckedModeBanner: false,
  ));
}