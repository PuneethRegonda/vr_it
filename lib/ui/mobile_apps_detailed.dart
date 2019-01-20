import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;
import 'dart:async';
import 'package:vr_it/utils/urls.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:universal_widget/universal_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:vr_it/data_models/mobileapps_dm.dart';
import 'package:vr_it/common/platform_button.dart';

String _appId;
MobileAppsDM _mobileAppsData = new MobileAppsDM();
var _progressBar = UniversalWidget(
  child: CircularProgressIndicator(),
);

var _height, _width;

class MobileAppDetailed extends StatefulWidget{

  MobileAppDetailed(String id){
    _appId = id;
  }

  @override
  State<StatefulWidget> createState() {
    return MobileAppDetailedState();
  }
}

class MobileAppDetailedState extends State<MobileAppDetailed> {

  MobileAppDetailedState(){
    _loadOnlineTraining().whenComplete((){
      setState(() {

      });
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
    _height = MediaQuery
        .of(context)
        .size
        .height;
    _width = MediaQuery
        .of(context)
        .size
        .width;

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
    if (_mobileAppsData.name == null) {
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
                    height: 5.0,
                  ),
                  SizedBox(
                    height: _height*2/10,
                    child: CachedNetworkImage(imageUrl: _mobileAppsData.logoUrl,fit: BoxFit.scaleDown,placeholder: CircularProgressIndicator(),errorWidget: Icon(Icons.error),),
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
                            _mobileAppsData.name,
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
                            _mobileAppsData.description,
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
                            'Ratings',
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
                            _mobileAppsData.rating,
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
                  SizedBox(
                    height: 20.0,
                  ),
                  PlatformButton(
                    child: SizedBox(
                      child: Text('Download App', style: TextStyle(color:Colors.white,fontSize: 17.0),),
                    ),
                    onPressed: (){

                    },
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Future _loadOnlineTraining() async {
    var response = await post(
        Urls.getMobileApp, body: {'id': _appId});
    var jsonData = json.decode(response.body);

    for (var p in jsonData) {
      MobileAppsDM trainingsDM = MobileAppsDM(
          id: p['id'],
          name: p['name'],
          description: p['description'],
          rating: p['rating'],
          link: p['link'],
          logoUrl: p['logoUrl']
      );
      _mobileAppsData = trainingsDM;
    }
  }
}