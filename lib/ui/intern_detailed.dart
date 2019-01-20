import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;
import 'dart:async';
import 'package:vr_it/utils/urls.dart';
import 'dart:convert';
import 'package:vr_it/data_models/interns_dm.dart';
import 'package:universal_widget/universal_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:vr_it/common/platform_button.dart';

String _internId;
InternshipsDM intern = new InternshipsDM();
var _progressBar = UniversalWidget(
  child: CircularProgressIndicator(),
);

var _height, _width;

class InternDetailed extends StatefulWidget {
  InternDetailed(String iid) {
    _internId = iid;
  }

  @override
  State<StatefulWidget> createState() {
    return InternDetailedState();
  }
}

class InternDetailedState extends State<InternDetailed> {
  InternDetailedState() {
    _loadIntern().whenComplete(() {
      setState(() {});
    });
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text('Special Offers'),
      centerTitle: true,
      backgroundColor: Colors.blue,
      leading: InkWell(
        child: Icon(
          Icons.keyboard_arrow_left,
          size: 38.0,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _getAppBar(),
      backgroundColor: Colors.blue,
      body: Stack(
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ),
          _showOffer(),
        ],
      ),
    );
  }

  Widget _showOffer() {
    if (intern.title == null) {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ));
    } else {
      return Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(style: BorderStyle.solid, color: Colors.white10),
        ),
        child: Material(
          animationDuration: Duration(milliseconds: 700),
          elevation: 20.0,
          child: SizedBox(
            height: _height * 9.5 / 10,
            width: _width * 9.5 / 10,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                          child: Text(
                            intern.title,
                            style: TextStyle(
                                fontSize: _height * .35 / 10,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        width: 5.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                          child: Text(
                            'Description',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: _height * .28 / 10,
                                fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                          child: Text(
                        intern.description,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: _height * .25 / 10,
                            fontWeight: FontWeight.w400),
                      )),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 10.0,
                      width: _width * 9 / 10,
                      child: Divider(
                        height: 5.0,
                        color: Colors.black,
                      )),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                          child: Text(
                            'Stipend',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: _height * .28 / 10,
                                fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        intern.stipend,
                        style: TextStyle(
                            fontSize: _height * .25 / 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                      height: 10.0,
                      width: _width * 9 / 10,
                      child: Divider(
                        height: 5.0,
                        color: Colors.black,
                      )),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                          child: Text(
                            'Skills Required',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: _height * .28 / 10,
                                fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                          child: Text(
                        intern.skillsReq,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: _height * .25 / 10,
                            fontWeight: FontWeight.w400),
                      )),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 10.0,
                      width: _width * 9 / 10,
                      child: Divider(
                        height: 5.0,
                        color: Colors.black,
                      )),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                          child: Text(
                            'Start Date',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: _height * .28 / 10,
                                fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        intern.startDate,
                        style: TextStyle(
                            fontSize: _height * .25 / 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                      height: 10.0,
                      width: _width * 9 / 10,
                      child: Divider(
                        height: 5.0,
                        color: Colors.black,
                      )),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                          child: Text(
                            'End Date',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: _height * .28 / 10,
                                fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        intern.endDate,
                        style: TextStyle(
                            fontSize: _height * .25 / 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                      height: 10.0,
                      width: _width * 9 / 10,
                      child: Divider(
                        height: 5.0,
                        color: Colors.black,
                      )),
                  PlatformButton(
                    color: Colors.blue,
                    child: SizedBox(
                      width: _width * 5 / 10,
                      child: Text(
                        'Apply Now!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Future _loadIntern() async {
    var response = await post(Urls.getIntern, body: {'id': _internId});
    var jsonData = json.decode(response.body);

    for (var p in jsonData) {
      intern = InternshipsDM(
          id: p['id'],
          title: p['title'],
          description: p['description'],
          period: p['period'],
          stipend: p['stipend'],
          skillsReq: p['skillsReq'],
          startDate: p['startDate'],
          endDate: p['endDate'],
          regFee: p['regFee']);
    }
//    print("Http response:  " + intern.id + "  " + intern.title);
  }
}
