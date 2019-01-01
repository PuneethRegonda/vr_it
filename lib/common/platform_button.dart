import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vr_it/common/platform_widget.dart';

class PlatformButton extends PlatformWidget<CupertinoButton, RaisedButton> {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;

  PlatformButton({this.child, this.onPressed, this.color});

  @override
  RaisedButton createAndroidWidget(BuildContext context) {
    return new RaisedButton(
      child: child,
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
    );
  }

  @override
  CupertinoButton createIosWidget(BuildContext context) {
    return new CupertinoButton(
      child: child,
      onPressed: onPressed,
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    );
  }
}