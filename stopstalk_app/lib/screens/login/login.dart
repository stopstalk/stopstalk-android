import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../dashboard.dart';
import 'login_form.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
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
            onPressed: () {},
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade, child: Dashboard()),
                  );
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
    );
  }
}
