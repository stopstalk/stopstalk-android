import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;

import '../profile.dart';

const SERVER_IP = 'http://10.0.2.2:8001';
final storage = FlutterSecureStorage();

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _loader = false;

  final TextEditingController _loginEmailController = TextEditingController();

  final TextEditingController _loginPasswordController =
      TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<String> attemptLogIn(String email, String password) async {
    var res = await http.get(
      "$SERVER_IP/api/login_token?email=$email&password=$password",
    );
    if (res.statusCode == 200) return res.body;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 20.0, left: 50.0, right: 25.0),
          child: TextField(
            /* focusNode: myFocusNodeEmailLogin, */
            controller: _loginEmailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                fontFamily: "WorkSansSemiBold",
                fontSize: 20.0,
                color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              icon: Icon(
                FontAwesomeIcons.envelopeOpen,
                color: Colors.white,
                size: 26.0,
              ),
              hintText: "Email Address",
              hintStyle: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 17.0,
                  color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50.0, left: 50.0, right: 25.0),
          child: TextField(
            /* focusNode: myFocusNodeEmailLogin, */
            controller: _loginPasswordController,
            obscureText: true,
            style: TextStyle(
                fontFamily: "WorkSansSemiBold",
                fontSize: 20.0,
                color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              icon: Icon(
                Icons.lock,
                color: Colors.white,
                size: 26.0,
              ),
              hintText: "Password",
              hintStyle: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 17.0,
                  color: Colors.white),
            ),
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent[400],
              borderRadius: BorderRadius.circular(8),
            ),
            child: MaterialButton(
              child: Center(
                widthFactor: 0.4,
                child: _loader
                    ? SpinKitCircle(size: 30.0, color: Colors.white)
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 160, vertical: 10),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "WorkSansBold"),
                        ),
                      ),
              ),
              onPressed: _loader
                  ? null
                  : () async {
                      setState(() => _loader = true);
                      var email = _loginEmailController.text;
                      var password = _loginPasswordController.text;
                      var jwt = await attemptLogIn(email, password);
                      setState(() => _loader = false);
                      if (jwt != null) {
                        storage.write(key: "jwt", value: jwt);
                        var data = json.decode(ascii.decode(base64
                            .decode(base64.normalize(jwt.split(".")[1]))));
                        storage.write(key: "user", value: data['user']);
                        Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ProfileScreen()),
                        );
                      } else {
                        displayDialog(context, "An Error Occurred",
                            "No account was found matching that username and password");
                        setState(() => _loader = false);
                      }
                    },
            ),
          ),
        ),
      ],
    );
  }
}
