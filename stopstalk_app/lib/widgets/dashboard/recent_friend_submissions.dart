import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../utils/platforms.dart';

class RecentFriendSubmissions extends StatelessWidget {
  final images = platformImgs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          Text(
            "Recent Friend Submissions",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Aditi Goyal",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage(
                              images["CODEFORCES".toLowerCase()],
                            ),
                            height: 40.0,
                            width: 40.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 2.0),
                          ),
                          Text(
                            "10",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage(
                              images["CODECHEF".toLowerCase()],
                            ),
                            height: 40.0,
                            width: 40.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 2.0),
                          ),
                          Text(
                            "4",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Abhijeet Verma",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage(
                              images["CODEFORCES".toLowerCase()],
                            ),
                            height: 40.0,
                            width: 40.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 2.0),
                          ),
                          Text(
                            "6",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage(
                              images["CODECHEF".toLowerCase()],
                            ),
                            height: 40.0,
                            width: 40.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 2.0),
                          ),
                          Text(
                            "3",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
          ),
          RaisedButton(
            elevation: 5,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Theme.of(context).buttonColor,
            child: AutoSizeText(
              'View All',
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
            padding: EdgeInsets.only(top: 8.0, bottom: 10.0),
          ),
        ],
      ),
    );
  }
}
