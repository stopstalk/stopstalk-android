import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class RecentFriendSubmissions extends StatelessWidget {
  final images = {
    "CODEFORCES":
        "https://1.bp.blogspot.com/-pBimI1ZhYAA/Wnde0nmCz8I/AAAAAAAABPI/5LZ2y9tBOZIV-pm9KNbyNy3WZJkGS54WgCPcBGAYYCw/s1600/codeforce.png",
    "CODECHEF":
        "https://i.pinimg.com/originals/c5/d9/fc/c5d9fc1e18bcf039f464c2ab6cfb3eb6.jpg",
    "HACKEREARTH":
        "https://upload.wikimedia.org/wikipedia/commons/e/e8/HackerEarth_logo.png",
    "HACKERRANK":
        "https://info.hackerrank.com/rs/487-WAY-049/images/Podcast-ChannelCover-Final.jpg",
    "OTHER":
        "https://coursereport-s3-production.global.ssl.fastly.net/rich/rich_files/rich_files/3942/s200/asia-developer-academy.png"
  };

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
                            image: NetworkImage(
                              images["CODEFORCES"],
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
                            image: NetworkImage(
                              images["CODECHEF"],
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
                            image: NetworkImage(
                              images["CODEFORCES"],
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
                            image: NetworkImage(
                              images["CODECHEF"],
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
            color: Color(0xFF2542ff),
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
