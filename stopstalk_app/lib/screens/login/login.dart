import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
        ),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "or",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: "WorkSansMedium"),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: Image.asset('assets/google.png')),
        FlatButton(
          onPressed: () {},
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
      ],
    );
  }
}
