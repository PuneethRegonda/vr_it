import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vr_it/common/platform_button.dart';
import 'dart:io';
import 'dart:async';
import 'package:vr_it/ui/bottom_option_app_intro.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final _formKey = GlobalKey<FormState>();
final _formKeyVerify = GlobalKey<FormState>();
final snackBar =
    SnackBar(content: Text('User verification completed succesfully'));

double _width, _height;
var _phone, _code, _verificationId, _orientation;

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
            centerTitle: true,
            title: Text(
              'Login',
            ),
            leading: InkWell(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomButtonsAppIntro()));
              },
            )),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _orientation == Orientation.portrait
                      ? _height * 0.5 / 10
                      : _height * 0.25 / 10,
                ),
                Center(
                  child: SizedBox(
                    height: _orientation == Orientation.portrait
                        ? _height * 4 / 10
                        : _height * 3 / 10,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Image.asset(
                        'assets/vr_it_logo.png',
                      ),
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
                              height: Platform.isAndroid
                                  ? _height * .6 / 10
                                  : _height * .3 / 10,
                              child: Center(
                                child: Text(
                                  'Get Verification Code',
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
        ));
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => VerifyPhone()));

//    Navigator.popAndPushNamed(context, '/verifyphone');
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
  VerifyPhoneState() {
    _verifyPhoneNumber();
  }

  String _verificationId;

  bool _codeVerified = false;
  Duration _timeOut = const Duration(minutes: 1);

  String _statusOfVerification =
      'Verification code has been sent to your mobile, please enter it to continue';

  Future<Null> _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91' + _phone,
      timeout: _timeOut,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
    );
    return null;
  }

  // PhoneCodeSent
  codeSent(String verificationId, [int forceResendingToken]) async {
    setState(() {
      this._verificationId = verificationId;
      _statusOfVerification =
          'Verification code has been sent to your mobile, please enter it to continue';
    });
    debugPrint('Phone verification code sent');
  }

  // PhoneCodeAutoRetrievalTimeout
  codeAutoRetrievalTimeout(String verificationId) {
    setState(() {
      this._verificationId = verificationId;
      debugPrint('Phone verification autoretrieval time out');
    });
  }

  Future<Null> _submitSmsCode() async {
    debugPrint('Phone verification submit sms code');
    if (this._codeVerified) {
      await _finishSignIn(await _auth.currentUser());
    } else {
      await _signInWithPhoneNumber();
    }
    return null;
  }

  Future<void> _signInWithPhoneNumber() async {
    await _auth
        .signInWithPhoneNumber(verificationId: _verificationId, smsCode: _code)
        .then((user) async {
      await _onCodeVerified(user).then((codeVerified) async {
        this._codeVerified = codeVerified;
        if (this._codeVerified) {
          await _finishSignIn(user);
        } else {
          _statusOfVerification = 'Phone verification failed, please try later';
        }
      });
    }, onError: (error) {
      _statusOfVerification = 'Phone verification failed, please try later';
      print("Failed to verify SMS code: $error");
    });
  }

  Future<bool> _onCodeVerified(FirebaseUser user) async {
    final isUserValid = (user != null &&
        (user.phoneNumber != null && user.phoneNumber.isNotEmpty));
    if (isUserValid) {
      setState(() {
        _statusOfVerification = 'Verification success';
      });
    } else {
      _statusOfVerification = 'Phone verification failed, please try later';
    }
    return isUserValid;
  }

  // PhoneVerificationCompleted
  verificationCompleted(FirebaseUser user) async {
    //Logger.log(TAG, message: "onVerificationCompleted, user: $user");
    debugPrint('Phone verification completed');
    if (await _onCodeVerified(user)) {
      await _finishSignIn(user);
    } else {
      setState(() {
        _statusOfVerification = 'Phone verification failed, please try later';
      });
    }
  }

  // PhoneVerificationFailed
  verificationFailed(AuthException authException) {
    debugPrint('Phone verification failed ' + authException.message);
    _statusOfVerification = 'Phone verification failed, please try later';
//    SnackBar(content: Text("We couldn't verify your code for now, please try again!"));
  }

  _finishSignIn(FirebaseUser user) async {
    await _onCodeVerified(user).then((result) {
      if (result) {
        debugPrint('Sigin in success');
        _statusOfVerification = 'Verification success';
        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        setState(() {
          _statusOfVerification = 'Phone verification failed, please try later';
        });
        debugPrint('Sigin in failed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
        ),
        leading: InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FirebaseLogin()));
            }),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SizedBox(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? _height * 0.5 / 10
                        : _height * 0.25 / 10,
              ),
              Center(
                child: SizedBox(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? _height * 4 / 10
                          : _height * 3 / 10,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Image.asset(
                      'assets/vr_it_logo.png',
                    ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            PlatformButton(
                              child: SizedBox(
                                width: _width * 3 / 10,
                                height: Platform.isAndroid
                                    ? _height * .6 / 10
                                    : _height * .3 / 10,
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
                                if (_formKeyVerify.currentState.validate()) {
                                  _formKeyVerify.currentState.save();
                                  _submitSmsCode();
                                }
                              },
                            ),
                            SizedBox(
                              width: Platform.isAndroid
                                  ? _width * 0.25 / 10
                                  : 10.0,
                            ),
                            PlatformButton(
                              child: SizedBox(
                                width: _width * 3 / 10,
                                height: Platform.isAndroid
                                    ? _height * .6 / 10
                                    : _height * .3 / 10,
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
                                setState(() {
                                  _statusOfVerification =
                                      'Verification code has been resent';
                                  _verifyPhoneNumber();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
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
}
