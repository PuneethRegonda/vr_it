import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vr_it/common/platform_widget.dart';

class PlatformScaffold extends PlatformWidget<CupertinoPageScaffold, Scaffold> {
  final String title;
  final Widget child;

  PlatformScaffold({this.title, this.child});

  @override
  Scaffold createAndroidWidget(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  Center(
        child: Text(title, textAlign: TextAlign.center,style: TextStyle(color:Colors.white),
        ),
      ),
        backgroundColor: Colors.pink,
      ),
      body: child,
    );
  }

  @override
  CupertinoPageScaffold createIosWidget(BuildContext context) {
    // TODO: implement createIosWidget
    return  CupertinoPageScaffold(
      navigationBar:  CupertinoNavigationBar(
        middle:  Text(title, textAlign: TextAlign.center, style: TextStyle(color:Colors.white),),
        backgroundColor: Colors.pink,
      ),
      child: child,

    );
  }
}