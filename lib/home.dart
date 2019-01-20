import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:vr_it/ui/profile.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:vr_it/data_models/promotions_dm.dart';
import 'package:vr_it/ui/promotion_detailed.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:vr_it/utils/urls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vr_it/ui/our_services.dart';

var orientation, height, width;

bool showProgress = false;

PageController pageController =
    new PageController(initialPage: 0, keepPage: true, viewportFraction: 1.0);

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              //activeIcon: Icon(Icons.home,color: Colors.black,),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              title: Text('Profile'),
              //activeIcon: Icon(Icons.person_pin,color: Colors.black,),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.class_),
              title: Text('My Activity'),
              //activeIcon: Icon(Icons.class_,color: Colors.black,),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text('Documents'),
              //  activeIcon: Icon(Icons.book,color: Colors.black,),
              backgroundColor: Colors.blue),
        ],
        onTap: (int currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
          });
        },
        fixedColor: Colors.blue,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text('Home'),
      centerTitle: true,
      backgroundColor: Colors.blue,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: InkWell(
            child: Icon(Icons.close),
            onTap: () {
              //I will close your app
              debugPrint('lets close the app');
            },
          ),
        )
      ],
    );
  }

  Widget _getBody() {
    if (_currentIndex == 0) {
      return _myHome();
    } else if (_currentIndex == 1) {
      return MyProfile();
    } else if (_currentIndex == 2) {
      return Center(
        child: Text('your activity'),
      );
    } else if (_currentIndex == 3) {
      return Center(
        child: Text('your classroom'),
      );
    } else {
      return Center();
    }
  }

  Widget _grid() {
    return GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.all(15.0),
      children: <Widget>[
        _makeMyGridItem('assets/internships.png', 'Internships', '1'),
        _makeMyGridItem('assets/mobile_and_apps.png', 'Mobile apps', '2'),
        _makeMyGridItem('assets/online_services.png', 'Online Training', '3'),
        _makeMyGridItem('assets/projects.png', 'BTech/MTech Projects', '4'),
        _makeMyGridItem('assets/tech_support.png', 'Tech Support', '5'),
        _makeMyGridItem('assets/software_management.png', 'Industrial Training', '6'),
      ],
      mainAxisSpacing: width * .2 / 10,
      crossAxisSpacing: width * .2 / 10,
    );
  }

  Widget _makeMyGridItem(String imageUrl, String title, String type) {
    return GestureDetector(
      onTap: () {
//        debugPrint('The page with $id clicked');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OurServices(type)));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white, width: 1.5, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fitWidth,
              ),
              padding: EdgeInsets.only(bottom: 10.0),
            ),
            Positioned(
              bottom: 1.0,
              right: 0.0,
              left: 0.0,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: height * .2 / 10,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myHome() {
    return Column(
      children: <Widget>[
        //Promotions and banner
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: SizedBox(
            height: height * 3 / 10,
            child: BannersList(),
          ),
        ),
        SizedBox(
          height: height * .5 / 10,
          child: Center(
            child: Text(
              'Our services',
              style: TextStyle(
                  fontSize: height * 0.35 / 10, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: _grid(),
        )
      ],
    );
  }
}

class BannersList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BannersListState();
  }
}

class BannersListState extends State<BannersList> {
  List<PromotionDM> _promotions = [];
  int _currentPageNumber = 0;

  BannersListState() {
    _loadPromotions().whenComplete(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _promotions.isEmpty
        ? Center(child: CircularProgressIndicator())
        : buildingPageView();
  }

  Widget buildingPageView() {
    return Stack(
      children: <Widget>[
        PageView.builder(
            controller: PageController(),
            itemCount: _promotions.length,
            scrollDirection: Axis.horizontal,
            physics: new ClampingScrollPhysics(),
            onPageChanged: (int i) {
              setState(() {
                _currentPageNumber = i;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => PromotionDetailed(_promotions[index].id.toString())));
//                  debugPrint(_promotions[index].id.toString() + "clicked");
                },
                child: CachedNetworkImage(
                  imageUrl: _promotions[index].imageUrl,
                  fit: BoxFit.fill,
                  placeholder: Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: Icon(Icons.error),
                ), //Image.network(_promotions[index].imageUrl,fit: BoxFit.fill,),
              );
            }),
        Positioned(
          child: Center(
            child: DotsIndicator(
              numberOfDot: _promotions.length,
              position: _currentPageNumber,
            ),
          ),
          bottom: 5.0,
          left: 0.0,
          right: 0.0,
        )
      ],
    );
  }

  Future _loadPromotions() async {
    var mData = await get(Urls.getBanners);
    var jsonData = json.decode(mData.body);
    List<PromotionDM> prom = [];
    for (var p in jsonData) {
      PromotionDM promotion = PromotionDM(
          id: p['id'],
          title: p['title'],
          imageUrl: p['imageUrl'],
          description: p['description']);
      prom.add(promotion);
    }
    _promotions = prom;
  }
}
