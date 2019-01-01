import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vr_it/common/platform_button.dart';
import 'dart:io';

//final GoogleSignIn _googleSignIn = GoogleSignIn();

final FirebaseAuth _auth = FirebaseAuth.instance;
final _formKey = GlobalKey<FormState>();
final _formKeyVerify = GlobalKey<FormState>();

double _width, _height;
var _phone, _code, _orientation;

class FirebaseLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FirebaseLoginState();
  }
}

class FirebaseLoginState extends State<FirebaseLogin> {
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login')),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _orientation == Orientation.portrait
                  ? _height * 0.75 / 10
                  : _height * 0.25 / 10,
            ),
            Center(
              child: SizedBox(
                height: _orientation == Orientation.portrait
                    ? _height * 4 / 10
                    : _height * 3 / 10,
                child: Image.asset(
                  'assets/vr_it_logo.png',
                ),
              ),
            ),
            SizedBox(
              child: Text(
                'Please enter your mobile number to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: _orientation == Orientation.portrait
                        ? _height * 0.225 / 10
                        : _height * 0.35 / 10),
              ),
              height: _height * 0.5 / 10,
            ),
            Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: _width * 8 / 10,
                        child: phoneField(),
                      ),
                      SizedBox(
                        height: _height * 0.25 / 10,
                      ),
                      PlatformButton(
                        child: SizedBox(
                          width: _width * 5 / 10,
                          height: _height * .6 / 10,
                          child: Center(
                            child: Text(
                              'Get Verification Code',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: _orientation == Orientation.portrait
                                      ? _height * 0.225 / 10
                                      : _height * 0.3 / 10,
                                  fontStyle: FontStyle.normal,
                                  decorationColor: Colors.white),
                            ),
                          ),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          //debugPrint('lets verify phone');
                          if (_formKey.currentState.validate())
                            _formKey.currentState.save();
                        },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget phoneField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          labelText: 'Enter your phone',
          hintText: 'Ex: 9502039079',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                  color: Colors.blue, style: BorderStyle.solid, width: 1.0))),
      validator: (String value) {
        if (value.length != 10) {
          return 'Invalid mobile number';
        }
      },
      onSaved: (String value) {
        _phone = value;
        _sendVerificationCode();
      },
    );
  }

  void _sendVerificationCode() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => VerifyPhone()));
  }
}

class VerifyPhone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VerifyPhoneState();
  }
}

class VerifyPhoneState extends State<VerifyPhone> {
  var _statusOfVerification =
      'Verification code has been sent to your mobile, please enter it to continue';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login')),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? _height * 0.75 / 10
                  : _height * 0.5 / 10,
            ),
            Center(
              child: SizedBox(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? _height * 4 / 10
                        : _height * 3 / 10,
                child: Image.asset(
                  'assets/vr_it_logo.png',
                ),
              ),
            ),
            SizedBox(
                height: _height * 0.75 / 10,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: Text(
                    '$_statusOfVerification',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: _orientation == Orientation.portrait
                            ? _height * 0.225 / 10
                            : _height * 0.35 / 10),
                  ),
                )),
            Form(
                key: _formKeyVerify,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: _width * 8 / 10,
                        child: verificationField(),
                      ),
                      SizedBox(
                        height: _height * 0.25 / 10,
                      ),
                      Padding(
                        padding: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? EdgeInsets.only(
                                left: _width * 1 / 10, bottom: 50.0)
                            : EdgeInsets.only(
                                left: _width * 1.25 / 10, bottom: 50.0),
                        child: Row(
                          children: <Widget>[
                            PlatformButton(
                              child: SizedBox(
                                width: _width * 3 / 10,
                                height: _height * .6 / 10,
                                child: Center(
                                  child: Text(
                                    'Verify Code',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            _orientation == Orientation.portrait
                                                ? _height * 0.225 / 10
                                                : _height * 0.3 / 10,
                                        fontStyle: FontStyle.normal,
                                        decorationColor: Colors.white),
                                  ),
                                ),
                              ),
                              color: Colors.blue,
                              onPressed: () {
                                //debugPrint('lets verify phone');
                                if (_formKeyVerify.currentState.validate())
                                  _formKeyVerify.currentState.save();
                              },
                            ),
                            SizedBox(
                              width: Platform.isAndroid ? _width * 0.55 / 10 : 10.0,
                            ),
                            PlatformButton(
                              child: SizedBox(
                                width: _width * 3 / 10,
                                height: _height * .6 / 10,
                                child: Center(
                                  child: Text(
                                    'Resend Code',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            _orientation == Orientation.portrait
                                                ? _height * 0.225 / 10
                                                : _height * 0.3 / 10,
                                        fontStyle: FontStyle.normal,
                                        decorationColor: Colors.white),
                                  ),
                                ),
                              ),
                              color: Colors.blue,
                              onPressed: () {
                                //debugPrint('lets verify phone');
                                if (_formKeyVerify.currentState.validate())
                                  _formKeyVerify.currentState.save();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget verificationField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: 'Enter verification code',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                  color: Colors.blue, style: BorderStyle.solid, width: 1.0))),
      validator: (String value) {
        if (value.length != 6) {
          return 'Invalid verification code';
        }
      },
      onSaved: (String value) {
        _code = value;
      },
    );
  }

  void _resendVerificationCode() {}

  void _verifyCode() {}
}
