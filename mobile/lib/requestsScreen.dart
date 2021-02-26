import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestsScreen extends StatefulWidget {
  @override
  _RequestsScreen createState() => _RequestsScreen();
}

class _RequestsScreen extends State<RequestsScreen> {
  Widget buildPending() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                  left: 01.0, right: 5.0, top: 0, bottom: 10),
              child: RaisedButton(
                elevation: 2,
                onPressed: () {},
                padding: EdgeInsets.all(25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1)),
                // color: Color(0xffAA15B2),
                color: Colors.white,
                child: Text('Pending Followers',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              )),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                  left: 01.0, right: 5.0, top: 0, bottom: 10),
              child: RaisedButton(
                elevation: 2,
                onPressed: () {},
                padding: EdgeInsets.all(25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1)),
                // color: Color(0xffAA15B2),
                color: Colors.white,
                child: Text('Status',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              )),
        ]));
  }

  Widget buildNav() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                    color: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Column(children: <Widget>[
                      Icon(
                        Icons.home,
                        color: Colors.black54,
                      ),
                      Text("Accept", style: TextStyle(color: Colors.black54))
                    ]))
              ],
            ),
          ),
        ),
        Expanded(
          child: new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                    color: Colors.transparent,
                    onPressed: () {},
                    child: Column(children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Color(0xffF015FC),
                      ),
                      Text("Requests",
                          style: TextStyle(
                              color: Color(0xffF015FC),
                              fontWeight: FontWeight.bold))
                    ]))
              ],
            ),
          ),
        ),
        Expanded(
          child: new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                    color: Colors.transparent,
                    onPressed: () {},
                    child: Column(children: <Widget>[
                      Icon(
                        Icons.message,
                        color: Colors.black54,
                      ),
                      Text("About", style: TextStyle(color: Colors.black54))
                    ]))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLogoutButton2() {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 255),
      width: 200,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('displayName', "");
          Navigator.pop(context);
          Navigator.pop(context);
        },
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xffAA15B2),
        // color: Colors.white,
        child: Text('Log Out',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Container(
            color: Colors.transparent,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 40, bottom: 0),
                    child: buildNav(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 40, bottom: 0),
                    child: buildPending(),
                  ),
                  Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 100, bottom: 0),
                        child: buildLogoutButton2(),
                      ),
                    ],
                  )
                      // margin: const EdgeInsets.only(
                      //     left: 20.0, right: 20.0, top: 40, bottom: 0),
                      // child: buildLogoutButton2(),
                      ),
                ])));
  }
}
