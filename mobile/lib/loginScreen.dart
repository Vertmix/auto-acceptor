import 'package:autoacceptor/dashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = "";
  String _password = "";
  String _error = "";
  String displayName = "";

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }

  changeText() {
    setState(() {
      _error = 'New Sample Text...';
    });
  }

  @override
  void initState() {
    getData();
    _getThingsOnStartup().then((value) {
      if (displayName != null && displayName != "") {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => DashboardScreen()));
      }
    });
    super.initState();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString('displayName');
    });
  }

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<String> _makeGetRequest() async {
    var response = await http.post(
        Uri.encodeFull("http://192.168.1.3:8000/instalogin?password=" +
            _password +
            "&email=" +
            _email +
            "&type=safe"),
        headers: {"Accept": "application/json"});

    print(response.body);

    if (response.body.contains("error")) {
      setState(() {
        _error = "Invalid credentials";
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("displayName", _email);
      setState(() {
        _error = "";
      });
    }
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _error,
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
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
            child: TextFormField(
                // onChanged: ,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black87),
                onChanged: (String value) {
                  _email = value;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xffF015FC),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.black38))))
      ],
    );
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
                onChanged: (String value) {
                  _password = value;
                },
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

  Widget buildLoginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // prefs.setString('displayName', _email);
          await _makeGetRequest();
          if (_error == "") {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => DashboardScreen()));
          }
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xffAA15B2),
        // color: Colors.white,
        child: Text('Login',
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
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
                child: Stack(
              children: <Widget>[
                Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image(image: AssetImage('assets/logo-white.png')),
                          Text(
                            'Instagram',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Acceptor',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal),
                          ),
                          Image(
                            image: AssetImage('assets/instagram.png'),
                            width: 300,
                          ),
                          buildEmail(),
                          buildPassword(),
                          buildLoginButton(),
                        ],
                      ),
                    ))
                // color: Colors.white,
              ],
            ))));
  }
}
