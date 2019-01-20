import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vr_it/utils/urls.dart';
import 'package:vr_it/data_models/interns_dm.dart';
import 'package:vr_it/data_models/online_training_dm.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'dart:async';
import 'package:universal_widget/universal_widget.dart';
import 'package:vr_it/ui/intern_detailed.dart';
import 'package:vr_it/ui/online_training_detailed.dart';
import 'package:vr_it/data_models/mobileapps_dm.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vr_it/ui/mobile_apps_detailed.dart';
import 'package:vr_it/data_models/industrial_training_dm.dart';
import 'package:vr_it/ui/industrial_training_detailed.dart';
import 'package:vr_it/data_models/tech_support_dm.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vr_it/data_models/projects_dm.dart';
import 'package:vr_it/ui/project_detailed.dart';

String _type;
var _height, _width;

List<InternshipsDM> _internships = [];
List<OnlineTrainingsDM> _onlineTrainings = [];
List<MobileAppsDM> _mobileApps = [];
List<IndustrialTrainingDM> _industrialTrainings = [];
List<TechSupportDM> _techSupports = [];
List<ProjectsDM> _projects = [];

var _progress = UniversalWidget(child: CircularProgressIndicator());

class OurServices extends StatefulWidget {
  OurServices(String type) {
    _type = type;
  }

  @override
  State<StatefulWidget> createState() {
    return OurServicesState();
  }
}

class OurServicesState extends State<OurServices> {
  OurServicesState() {
    switch (_type) {
      case '1':
        _loadInterns().whenComplete(() {
          setState(() {
            _progress.update(visible: false);
          });
        });
        break;
      case '2':
        _loadMobApss().whenComplete(() {
          setState(() {
//            _progress.update(visible: false);
          });
        });
        break;
      case '3':
        _loadOnlineServices().whenComplete(() {
          setState(() {
            _progress.update(visible: false);
          });
        });
        break;
      case '4':
        _loadProjects().whenComplete(() {
          setState(() {
            _progress.update(visible: false);
          });
        });
        break;
      case '5':
        _loadTechSupport().whenComplete(() {
          setState(() {
            _progress.update(visible: false);
          });
        });
        break;
      case '6':
        _loadIndustrialTraining().whenComplete(() {
          setState(() {
            _progress.update(visible: false);
          });
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(),
    );
  }

  Widget _getAppBar() {
    return AppBar(
      title: Text('Our Services'),
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

  Widget _getBody() {
    setState(() {
      _progress.update(visible: true);
    });
    switch (_type) {
      case '1':
        return _getInternBody();
      case '3':
        return _getOnlineServicesBody();
      case '2':
        return _getMobAppsBody();
      case '4':
        return _getProjectsBody();
      case '5':
        return _getTechSupportBody();
      case '6':
        return _getIndustrialTrainingBody();
      default:
        return Center(child: CircularProgressIndicator());
    }
  }

  Widget _getInternBody() {
    if (_internships.length == 0) {
      return Center(
        child: _progress,
      );
    } else {
      return ListView.builder(
          itemCount: _internships.length,
          itemBuilder: (BuildContext context, int id) {
            return Container(
              padding: EdgeInsets.all(10.0),
              width: _width * 9.5 / 10,
              height: _height * 2.4 / 10,
              child: Material(
                elevation: 10.0,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InternDetailed(
                                  _internships[id].id.toString())));
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 7.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: Text(
                                _internships[id].title,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600),
                              ),
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
                              'Skills: ${_internships[id].skillsReq}',
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400),
                            )),
                            SizedBox(
                              width: 15.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                                child: Text(
                              'Period: ${_internships[id].period}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400),
                            )),
                            SizedBox(
                              width: 15.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                                child: Text(
                              'Stipend: ${_internships[id].stipend}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400),
                            )),
                            SizedBox(
                              width: 15.0,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            );
          });
    }
  }

  Widget _getMobAppsBody() {
    if (_mobileApps.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
          itemCount: _mobileApps.length,
          itemBuilder: (BuildContext context, int id) {
            return Container(
              padding: EdgeInsets.all(10.0),
              width: _width * 9.5 / 10,
              height: _height * 2.4 / 10,
              child: Material(
                elevation: 10.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MobileAppDetailed(
                                _mobileApps[id].id.toString())));
                  },
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 5.0,
                      ),
                      SizedBox(
                        width: _width * 2.5 / 10,
                        height: _height * 2.5 / 10,
                        child: CachedNetworkImage(
                          fit: BoxFit.scaleDown,
                          imageUrl: _mobileApps[id].logoUrl,
                          placeholder: Center(
                            child: SizedBox(
                              height: 50.0,
                              width: 50.0,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: Icon(Icons.error),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 7.0,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                  child: Text(
                                    _mobileApps[id].name,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                  child: Text(
                                    'Rating: ${_mobileApps[id].rating}',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                  child: Text(
                                    _mobileApps[id].description,
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  Widget _getOnlineServicesBody() {
    if (_onlineTrainings.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
          itemCount: _onlineTrainings.length,
          itemBuilder: (BuildContext context, int id) {
            return Container(
              padding: EdgeInsets.all(10.0),
              width: _width * 9.5 / 10,
              height: _height * 2.4 / 10,
              child: Material(
                elevation: 10.0,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnlineTrainingDetailed(
                                  _onlineTrainings[id].id.toString())));
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 7.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: Text(
                                _onlineTrainings[id].title,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600),
                              ),
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
                              'Cost: ${_onlineTrainings[id].cost}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400),
                            )),
                            SizedBox(
                              width: 15.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                                child: Text(
                              'Duration: ${_onlineTrainings[id].duration}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400),
                            )),
                            SizedBox(
                              width: 15.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                                child: Text(
                              _onlineTrainings[id].description,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400),
                            )),
                            SizedBox(
                              width: 15.0,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            );
          });
    }
  }

  Widget _getProjectsBody() {
    if (_projects.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
          itemCount: _projects.length,
          itemBuilder: (BuildContext context, int id) {
            return Container(
              padding: EdgeInsets.all(10.0),
              width: _width * 9.5 / 10,
              height: _height * 2.4 / 10,
              child: Material(
                elevation: 10.0,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectDeailed(
                                  _projects[id].id.toString())));
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                                child: Text(
                                  _projects[id].title,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: _height * .35 / 10,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w700),
                                )),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                                child: Text(
                                  _projects[id].description,
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: _height * .25 / 10,
                                      fontWeight: FontWeight.w400),
                                )),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                                child: Text(
                                  'Standard: ${_projects[id].std}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: _height * .25 / 10,
                                      fontWeight: FontWeight.w400),
                                )),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    )),
              ),
            );
          });
    }
  }

  Widget _getTechSupportBody() {
    if (_techSupports.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
          itemCount: _techSupports.length,
          itemBuilder: (BuildContext context, int id) {
            return Container(
              padding: EdgeInsets.all(10.0),
              width: _width * 9.5 / 10,
              height: _height * 2.4 / 10,
              child: Material(
                elevation: 10.0,
                child: InkWell(
                    onTap: () {

                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                        _techSupports[id].type,
                                        style: TextStyle(
                                            fontSize: _height * .35 / 10,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w700),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 7.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                        'Description: ${_techSupports[id].description}',
                                        maxLines: 4,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: _height * .25 / 10,
                                            fontWeight: FontWeight.w400),
                                      )),
                                ],
                              ),
                            ],
                          )
                        ),
                        SizedBox(
                          width: 80.0,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 15.0,
                              ),
                              InkWell(
                                child: Center(child: Icon(Icons.phone,size: 50.0,color: Colors.blue,),),
                                onTap: (){
                                  launch("tel:+91 9502039079");
                                  debugPrint('call ${_techSupports[id].phone}' );
                                },
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              InkWell(
                                child: Center(child: Icon(Icons.email,size: 50.0,color: Colors.blue,),),
                                onTap: (){
                                  launch("mailto:${_techSupports[id].email}?subject=Support Request&body=");
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                ),
              ),
            );
          });
    }
  }

  Widget _getIndustrialTrainingBody() {
    if (_industrialTrainings.length == 0) {
      return Center(
        child: _progress,
      );
    } else {
      return ListView.builder(
          itemCount: _industrialTrainings.length,
          itemBuilder: (BuildContext context, int id) {
            return Container(
              padding: EdgeInsets.all(10.0),
              width: _width * 9.5 / 10,
              height: _height * 2.4 / 10,
              child: Material(
                elevation: 10.0,
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IndustrialTrainingDetailed(
                                  _industrialTrainings[id].id.toString())));
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 7.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: Text(
                                _industrialTrainings[id].title,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w600),
                              ),
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
                                  'Skills: ${_industrialTrainings[id].skillsReq}',
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                )),
                            SizedBox(
                              width: 15.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                                child: Text(
                                  'Period: ${_industrialTrainings[id].period}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                )),
                            SizedBox(
                              width: 15.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                                child: Text(
                                  'Stipend: ${_industrialTrainings[id].stipend}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                )),
                            SizedBox(
                              width: 15.0,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            );
          });
    }
  }

  Future _loadInterns() async {
    var response = await get(Urls.getInterns);
    var jsonData = json.decode(response.body);

    _internships = [];

    for (var p in jsonData) {
      InternshipsDM intern = InternshipsDM(
          id: p['id'],
          title: p['title'],
          description: p['description'],
          period: p['period'],
          stipend: p['stipend'],
          skillsReq: p['skillsReq'],
          startDate: p['startDate'],
          endDate: p['endDate'],
          regFee: p['regFee']);
      _internships.add(intern);
    }
    // debugPrint("internships data :  " + _internships[0].title + "\n" + _internships[1].toString());
  }

  Future _loadOnlineServices() async {
    var response = await get(Urls.getOnlineTrainings);
    var jsonData = json.decode(response.body);

    _onlineTrainings = [];

    for (var p in jsonData) {
      OnlineTrainingsDM trainingsDM = OnlineTrainingsDM(
          id: p['id'],
          title: p['title'],
          description: p['description'],
          cost: p['cost'],
          duration: p['duration']);

      _onlineTrainings.add(trainingsDM);
    }
    // debugPrint("internships data :  " + _onlineTrainings[0].title + "\n" + _onlineTrainings[1].toString());
  }

  Future _loadMobApss() async {
    var response = await get(Urls.getMobileApps);
    var jsonData = json.decode(response.body);

    _mobileApps = [];

    for (var p in jsonData) {
      MobileAppsDM intern = MobileAppsDM(
          id: p['id'],
          name: p['name'],
          description: p['description'],
          rating: p['rating'],
          link: p['link'],
          logoUrl: p['logoUrl']);
      _mobileApps.add(intern);
//      debugPrint(intern.logoUrl);
    }
 //   print("Http response:  " + _mobileApps.length.toString());
  }

  Future _loadProjects() async {
    var response = await get(Urls.getProjects);
    var jsonData = json.decode(response.body);

    _projects = [];

    for (var p in jsonData) {
      ProjectsDM intern = ProjectsDM(
          id: p['id'],
          title: p['title'],
          description: p['description'],
          std: p['std'],
          requirements: p['requirements'],
          cost: p['cost'],
          type: p['type']);
      _projects.add(intern);
    }
//    print("Http response:  " + _projects.length.toString());
  }

  Future _loadTechSupport() async {
    var response = await get(Urls.getTechSupports);
    var jsonData = json.decode(response.body);

    _techSupports = [];

    for (var p in jsonData) {
      TechSupportDM intern = TechSupportDM(
          id: p['id'],
          phone: p['phone'],
          email: p['email'],
          type: p['type'],
          description: p['description']);
      _techSupports.add(intern);
    }
//    print("Http response:  " + _techSupports.length.toString());
  }

  Future _loadIndustrialTraining() async {
    var response = await get(Urls.getIndustrialTrainings);
    var jsonData = json.decode(response.body);

    _industrialTrainings = [];

    for (var p in jsonData) {
      IndustrialTrainingDM intern = IndustrialTrainingDM(
          id: p['id'],
          title: p['title'],
          description: p['description'],
          period: p['period'],
          stipend: p['stipend'],
          skillsReq: p['skillsReq'],
          startDate: p['startDate'],
          endDate: p['endDate'],
          regFee: p['regFee']);
      _industrialTrainings.add(intern);
    }
//    print("Http response: industial trainings  " + _industrialTrainings.length.toString());
  }
}
