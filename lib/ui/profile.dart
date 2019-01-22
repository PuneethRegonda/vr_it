import 'package:flutter/material.dart';

double _width,_height;

String url =
    'https://2.bp.blogspot.com/-8ytYF7cfPkQ/WkPe1-rtrcI/AAAAAAAAGqU/FGfTDVgkcIwmOTtjLka51vineFBExJuSACLcBGAs/s320/31.jpg';

class MyProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyProfileState();
  }
}

class MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 15.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 10.0,
            ),
            Container(
                width: 100.0,
                height: 100.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill, image: new NetworkImage(url)))),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Fabiha khan',
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'User Id: 7510',
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Software Engineer',
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ],
              )
            ),
          ],
        ),
        SizedBox(
          height: 15.0,
        ),
        SizedBox(
            height: 10.0,
            width: _width*9.7/10,
            child: Divider(
              height: 5.0,
              color: Colors.black,
            )),
          ],
    );
  }
}
