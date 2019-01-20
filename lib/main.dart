import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

void main() {
  FirebaseAuth _auth = FirebaseAuth.instance;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    //user signed in
    title: 'VR IT Groups',
    home: Home(),
//    OurServices('Internships'),
//    _auth.currentUser() != null
//        ? BottomButtonsAppIntro()
//        : FirebaseLogin(),
    debugShowCheckedModeBanner: false,
  ));
}