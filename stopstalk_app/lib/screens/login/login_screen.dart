import 'package:flutter/material.dart';
import 'package:stopstalkapp/utils/auth.dart';
import '../profile.dart';
import './background.dart';
import './login.dart';
import '../../fragments/animations.dart';
import '../../utils/auth.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    checkIfUserIsLoggedIn(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.blue[400],
        body: Stack(
          children: <Widget>[
            FadeIn(Background(), 0),
            FadeIn(Login(), 2),
          ],
        ));
  }

  Future checkIfUserIsLoggedIn(context) async {
    var user = await getCurrentUser();
    if (user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ProfileScreen(handle: user.stopstalkHandle);
      }));
    }
  }
}
