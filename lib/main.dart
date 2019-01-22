import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vr_it/ui/bottom_option_app_intro.dart';
import 'home.dart';
import 'package:vr_it/ui/play_video.dart';

bool isNew = true;

void main() {

  FirebaseAuth _auth = FirebaseAuth.instance;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//  _print().whenComplete((){
//
//  });
 // Future<FirebaseUser> user = _auth.currentUser();
  //debugPrint(user.uid);
  runApp(MaterialApp(
    //user signed in
    title: 'VR IT Groups',
    home: _auth.currentUser() == null
        ? BottomButtonsAppIntro()
        : Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class PreLoader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

Future _print() async{
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  if(user.uid == null)
    isNew = true;
  else
    isNew = false;
}