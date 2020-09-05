import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 20.0, left: 50.0, right: 25.0),
          child: TextField(
            /* focusNode: myFocusNodeEmailLogin,
            controller: loginEmailController, */
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
            /* focusNode: myFocusNodeEmailLogin,
            controller: loginEmailController, */
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 42.0),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "WorkSansBold"),
                  ),
                ),
                onPressed: null),
          ),
        ),
      ],
    );
  }
}
