import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

import '../profile.dart';

import '../../utils/api.dart';
import '../../utils/storage.dart';
import '../../utils/auth.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _loader = false;
  bool _passwordVisible = false;

  final TextEditingController _loginEmailController = TextEditingController();

  final TextEditingController _loginPasswordController =
      TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.warning),
                SizedBox(width: 7),
                Text(title),
              ],
            ),
            content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 1.2,
      child: Column(
        children: [
          TextFormField(
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
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: TextFormField(
              /* focusNode: myFocusNodeEmailLogin, */
              controller: _loginPasswordController,
              obscureText: !_passwordVisible,
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
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                hintText: "Password",
                hintStyle: TextStyle(
                    fontFamily: "WorkSansSemiBold",
                    fontSize: 17.0,
                    color: Colors.white),
              ),
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              "Forgot Password ?",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontSize: 13.0,
                  fontFamily: "WorkSansMedium"),
            ),
          ),
          SizedBox(height: 25),
          Container(
            width: width / 2,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent[400],
              borderRadius: BorderRadius.circular(8),
            ),
            child: MaterialButton(
              child: _loader
                  ? SpinKitCircle(size: 30.0, color: Colors.white)
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
              onPressed: _loader
                  ? null
                  : () async {
                      setState(() => _loader = true);
                      var email = _loginEmailController.text;
                      var password = _loginPasswordController.text;
                      if (email == '' || password == '') {
                        displayDialog(context, "An Error Occurred",
                            "Email and password cannot be empty");
                        setState(() => _loader = false);
                      } else {
                        var jwt = await attemptLogIn(email, password);
                        setState(() => _loader = false);
                        if (jwt != null) {
                          await writeDataSecureStore("jwt", jwt);
                          var user = await getCurrentUser();
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: ProfileScreen(
                                  handle: user.stopstalkHandle,
                                  isUserItself: true,
                                )),
                          );
                        } else {
                          displayDialog(context, "An Error Occurred",
                              "No account was found matching that username and password");
                          setState(() => _loader = false);
                        }
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }
}
