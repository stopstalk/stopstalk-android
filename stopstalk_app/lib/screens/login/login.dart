import 'package:flutter/material.dart';
import 'package:stopstalkapp/classes/dashboard_class.dart';
import 'package:stopstalkapp/utils/googleLogin.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dashboard.dart';
import '../upcoming_contest_screen.dart';
import 'login_form.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              ),
              LoginForm(),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 12),
                child: Text("or",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: "WorkSansMedium")),
              ),
              FlatButton(
                padding: EdgeInsets.all(0.0),
                child: Image.asset(
                  'assets/images/google.png',
                  width: width / 2,
                ),
                onPressed: () {
                  loginWithGoogle(context);
                },
              ),
              SizedBox(height: 20),
              Text(
                "New Here ?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontFamily: "WorkSansMedium"),
              ),
              FlatButton(
                onPressed: () {
                  _launchURL("https://www.stopstalk.com/");
                },
                child: Text(
                  "Register On Site",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 17.0,
                      fontFamily: "WorkSansMedium"),
                ),
              ),
              Text(
                "or",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontFamily: "WorkSansMedium"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                          Dashboard.routeName,
                          arguments: DashboardClass(loggedin: false));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue As Guest",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontFamily: "WorkSansMedium"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(Icons.arrow_forward, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
