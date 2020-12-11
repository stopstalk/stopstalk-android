import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PickATag extends StatelessWidget {
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
            "Pick a Tag",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextFormField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Type some tag...",
                  hintStyle: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          Container(
            width: 120.0,
            child: RaisedButton(
              elevation: 5,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Color(0xFF2542ff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                  AutoSizeText(
                    ' Search',
                    maxLines: 1,
                    minFontSize: 7,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
        ],
      ),
    );
  }
}
