import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'package:vr_it/utils/urls.dart';
import 'dart:convert';
import 'package:vr_it/data_models/promotions_dm.dart';
import 'package:universal_widget/universal_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vr_it/common/platform_button.dart';

String _promotionId;
PromotionDM promotion;
var _progressBar = UniversalWidget(
  child: CircularProgressIndicator(),
);
bool dataLoaded = false;

var height, width;

class PromotionDetailed extends StatefulWidget {
  PromotionDetailed(String prid) {
    _promotionId = prid;
  }

  @override
  State<StatefulWidget> createState() {
    return PromotionDetailedState();
  }
}

class PromotionDetailedState extends State<PromotionDetailed> {
  PromotionDetailedState() {
    _loadPromotion().whenComplete(() {
      setState(() {
        dataLoaded = true;
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
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _getAppBar(),
      backgroundColor: Colors.blue,
      body: Stack(
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          ),
          _showOffer(),
        ],
      ),
    );
  }

  Widget _showOffer() {
    if(promotion.imageUrl ==""){
      return Center(
        child: CircularProgressIndicator(),
      );
    }else {
      return Container(
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(style: BorderStyle.solid, color: Colors.white10),
        ),
        child: Material(
          animationDuration: Duration(milliseconds: 700),
          elevation: 15.0,
          child: SizedBox(
            height: height * 9.5 / 10,
            width: width * 9.5 / 10,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: promotion.imageUrl,
                      placeholder: CircularProgressIndicator(),
                      errorWidget: Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                          child: Text(
                            promotion.title,
                            style: TextStyle(
                                fontSize: height * .35 / 10,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        width: 5.0,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                          child: Text(
                            promotion.description,
                            style: TextStyle(
                                fontSize: height * .28 / 10,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          )),
                      SizedBox(
                        width: 5.0,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  PlatformButton(
                    color: Colors.blue,
                    child: SizedBox(
                      width: width * 5 / 10,
                      child: Text(
                        'Avail this Offer',
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

  Future _loadPromotion() async {
    var response = await post(Urls.getBanner, body: {'id': _promotionId});
    var jsonData = json.decode(response.body);

    for (var p in jsonData) {
      promotion = PromotionDM(
          id: p['id'],
          title: p['title'],
          imageUrl: p['imageUrl'],
          description: p['description']);
    }
//    print("Http response:  " + promotion.imageUrl);
  }
}
