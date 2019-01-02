import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vr_it/common/platform_button.dart';
import 'package:vr_it/ui/firebase_login.dart';

var _orientation;

class BottomButtonsAppIntro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BottomButtonsAppIntroState();
  }
}

class BottomButtonsAppIntroState extends State<BottomButtonsAppIntro> {
  double width, height;
  static final PageController pageController = new PageController();
  static int pos = 0;

  static List<Widget> _pages = <Widget>[
    Page('VR IT Group', 'We heartily welcome you to VR IT Groups',
        'assets/vr_it_logo.png', Colors.white10),
    Page('Project Management', 'Description about project management',
        'assets/product_management.png', Colors.white10),
    Page('Online Services', 'Description about online services',
        'assets/online_services.png', Colors.white10),
    Page('Mobile apps', 'Description about mobile apps',
        'assets/mobile_and_apps.png', Colors.white10),
    Page('Internships', 'Description about interns',
        'assets/internships.png', Colors.white10),
    Page('Software Management', 'Description about software management',
        'assets/software_management.png', Colors.white10),
    Page('Tech Support', 'Description about Tech Support',
        'assets/tech_support.png', Colors.white10),
  ];

  static const _kDuration = const Duration(milliseconds: 300);
  var _dotIndicatorPlus = new DotsIndicatorPlus(
    controller: pageController,
    itemCount: _pages.length,
    onPageSelected: (int page) {
      pageController.animateToPage(page,
          duration: _kDuration, curve: Curves.decelerate);
    },
    color: Colors.blueAccent,
  );

  @override
  Widget build(BuildContext context) {

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    _orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: 400),
            child: PageView.builder(
              physics: new ClampingScrollPhysics(),
              controller: pageController,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
              itemCount: _pages.length,
              onPageChanged: (int value) {
                setState(() {
                  pos = value;
                });
              },
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).orientation == Orientation.portrait ? height * 2/ 10 : height*2.30/10,
            right: 0.0,
            left: 0.0,
            child: Center(
              child: _dotIndicatorPlus,
            ),
          ),
          Positioned(
              right: width*0.5/10,
              left: width*0.5/10,
              bottom: height * 0.45 / 10,
              child: _bottomMenu()),
        ],
      ),
    );
  }

  Widget _bottomMenu() {
    return Column(
      children: <Widget>[
        PlatformButton(
          child: SizedBox(
            width: width*9/10,
            height: height*.7/10,
            child: Center(
              child: Text(
                'Login with OTP',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).orientation == Orientation.portrait? height*0.225/10 : height*0.32/10 ,fontStyle: FontStyle.normal,decorationColor: Colors.white),
              ),
            ),
          ),
          color: Colors.blue,
          onPressed: () {
            //debugPrint('lets login');
//            Navigator.of(context).push(
//                MaterialPageRoute(builder: (context) => FirebaseLogin()));
            Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) => FirebaseLogin()));
//            Navigator.of(context).push(
//                MaterialPageRoute(builder: (context) => FirebaseLogin()));
//            Navigator.of(context).popAndPushNamed('login',)
          },
        ),
        SizedBox(
          height: height*0.25/10,
        ),
        InkWell(
          child: Text('Terms and Conditions',textAlign: TextAlign.center,style: TextStyle(fontSize: MediaQuery.of(context).orientation == Orientation.portrait ? height*0.202/10 : height*0.30/10),),
          onTap: (){
            debugPrint('Go to agreement page');
          },
        )
      ],
    );
  }
}

class DotsIndicatorPlus extends AnimatedWidget {
  DotsIndicatorPlus({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  static const double _kDotSize = 6.0;
  static const double _kMaxZoom = 1.5;
  static const double _kDotSpacing = 18.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );

    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class Page extends StatelessWidget {
  double _height;
  String title, description, icon;
  Color backgroundColor;

  Page(this.title, this.description, this.icon, this.backgroundColor);

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;

    TextStyle titleStyle = new TextStyle(
        color: Colors.black87, fontSize: MediaQuery.of(context).orientation == Orientation.portrait ? _height*0.41/10 : _height*.55/10, fontWeight: FontWeight.w700);
    TextStyle desc = new TextStyle(
        color: Colors.grey, fontSize: MediaQuery.of(context).orientation == Orientation.portrait ? _height*0.25/10 : _height*0.35/10, fontWeight: FontWeight.w400);

    return Scaffold(
        backgroundColor: backgroundColor,
        body: SizedBox(
          height: _height * 8.5 / 10,
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).orientation == Orientation.portrait ? _height * 1 / 10 : _height * 0.5 / 10,
                  bottom: MediaQuery.of(context).orientation == Orientation.portrait ? _height * 0.75 / 10 : _height * 0.25 / 10,
                  left: 20.0,
                  right: 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _height*4/10,
                    child: Image.asset(icon),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: titleStyle,
                    textDirection: TextDirection.ltr,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: desc,
                    textDirection: TextDirection.ltr,
                  ),
                ],
              )),
        ));
  }
}


