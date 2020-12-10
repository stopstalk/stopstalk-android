import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Mood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xffeeeeee),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            color: Colors.grey,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Mood",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          Text(
            "Let's find you some problem that you can start solving.",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                elevation: 5,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Color(0xFF2542ff),
                child: AutoSizeText(
                  'Easy',
                  maxLines: 1,
                  minFontSize: 7,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {},
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              RaisedButton(
                elevation: 5,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Color(0xFF2542ff),
                child: AutoSizeText(
                  'Medium',
                  maxLines: 1,
                  minFontSize: 7,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {},
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              RaisedButton(
                elevation: 5,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Color(0xFF2542ff),
                child: AutoSizeText(
                  'Hard',
                  maxLines: 1,
                  minFontSize: 7,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
        ],
      ),
    );
  }
}
