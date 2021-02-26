import 'package:autoacceptor/requestsScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  String displayName = "";
  String chosenColor = "Burst";
  int safeColor = 0;
  int burstColor = 0;
  int quickColor = 0;

  changeModeColor(String mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("chosenColor", mode);
    if (mode == "Safe") {
      setState(() {
        safeColor = 0xffF015FC;
        burstColor = 0;
        quickColor = 0;
      });
    }
    if (mode == "Burst") {
      setState(() {
        burstColor = 0xffF015FC;
        safeColor = 0;
        quickColor = 0;
      });
    }
    if (mode == "Quick") {
      setState(() {
        quickColor = 0xffF015FC;
        safeColor = 0;
        burstColor = 0;
      });
    }
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 0));
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    displayName = prefs.getString('displayName');
    chosenColor = prefs.getString('chosenColor');
  }

  @override
  void initState() {
    getData();
    _getThingsOnStartup().then((value) {
      changeModeColor(chosenColor);
    });
    super.initState();
  }

  Future<String> _changeMode(String reqType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getData();
    var response = await http.post(
        Uri.encodeFull("http://192.168.1.3:8000/changeTo" +
            reqType +
            "?email=" +
            displayName),
        headers: {"Accept": "application/json"});
    changeModeColor(reqType);
    print(displayName);
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   'Password',
        //   style: TextStyle(color: Colors.white, fontSize: 16),
        // ),
        SizedBox(height: 10),
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
                obscureText: true,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xffF015FC),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.black38))))
      ],
    );
  }

  Widget buildLogoutButton() {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 255),
      width: 200,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('displayName', "");
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
  // image: AssetImage('assets/logo-white.png'),

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
                    onPressed: () {},
                    child: Column(children: <Widget>[
                      Icon(
                        Icons.home,
                        color: Color(0xffF015FC),
                      ),
                      Text("Accept",
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => RequestsScreen()));
                    },
                    child: Column(children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                      Text("Requests", style: TextStyle(color: Colors.black54))
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

  Widget buildModes() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Color(safeColor))),
              margin: const EdgeInsets.only(
                  left: 01.0, right: 5.0, top: 0, bottom: 10),
              child: RaisedButton(
                elevation: 2,
                onPressed: () {
                  _changeMode("Safe");
                },
                padding: EdgeInsets.all(25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1)),
                // color: Color(0xffAA15B2),
                color: Colors.white,
                child: Text('Safe',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              )),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Color(burstColor))),
              margin: const EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 0, bottom: 10),
              child: RaisedButton(
                elevation: 2,
                onPressed: () {
                  _changeMode("Burst");
                },
                padding: EdgeInsets.all(25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1)),
                // color: Color(0xffAA15B2),
                color: Colors.white,
                child: Text('Burst',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              )),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Color(quickColor))),
              margin: const EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 0, bottom: 10),
              child: RaisedButton(
                elevation: 2,
                onPressed: () {
                  _changeMode("Quick");
                },
                padding: EdgeInsets.all(25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1)),
                // color: Color(0xffAA15B2),
                color: Colors.white,
                child: Text('Quick',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              )),
        ]));
  }

  Widget buildStats() {
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
                child: Text('Accepted today',
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
                child: Text('Accepted All-Time',
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
                child: Text('Currently Accepting',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              )),
        ]));
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
                        left: 20.0, right: 20.0, top: 0, bottom: 10),
                    child: buildModes(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 0, bottom: 10),
                    child: buildStats(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20, bottom: 20),
                    child: buildLogoutButton(),
                  ),
                ])));
  }
}
