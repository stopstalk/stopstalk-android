import 'package:flutter/material.dart';
import 'login_form.dart';

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
        LoginForm(),
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
