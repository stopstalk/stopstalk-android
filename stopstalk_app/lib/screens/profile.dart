import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../widgets/app_drawer.dart';
import '../widgets/streaks_profile.dart';
import '../widgets/platform_data_profile.dart';
import '../widgets/acceptance_graph.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  TextStyle get titleTextStyle => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2542ff),
        elevation: 0,
        toolbarHeight: 40,
      ),
      drawer: AppDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? MediaQuery.of(context).size.height * 0.4
                          : MediaQuery.of(context).size.height * 0.18,
                    ),
                    Positioned(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? MediaQuery.of(context).size.height * 0.2
                            : MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: Colors.grey,
                              offset: Offset(0.0, 3.0),
                            ),
                          ],
                          color: Color(0xFF2542ff),
                        ),
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.35,
                      child: AutoSizeText(
                        "My Profile",
                        minFontSize: 15,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? MediaQuery.of(context).size.height * 0.075
                          : MediaQuery.of(context).size.height * 0.047,
                      left: MediaQuery.of(context).size.width * 0.15,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? MediaQuery.of(context).size.height * 0.3
                            : MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2.0,
                              color: Colors.grey,
                              offset: Offset(0.0, 3.0),
                            ),
                          ],
                          color: Color(0xFF0018ca),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    "Aditi Goyal",
                                    minFontSize: 15,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      'LR SM Vissanjii Academy School',
                                      minFontSize: 10,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.network(
                                    'https://www.stopstalk.com/static/flag-icon/flags/4x3/in.svg',
                                    width: 65,
                                    height: 45,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Platforms',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? MediaQuery.of(context).size.height * 0.3
                      : MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ProfilePlatformData(
                        platformImgUrl:
                            'https://1.bp.blogspot.com/-pBimI1ZhYAA/Wnde0nmCz8I/AAAAAAAABPI/5LZ2y9tBOZIV-pm9KNbyNy3WZJkGS54WgCPcBGAYYCw/s1600/codeforce.png',
                        solvedCount: 65,
                      ),
                      ProfilePlatformData(
                        platformImgUrl:
                            'https://i.pinimg.com/originals/c5/d9/fc/c5d9fc1e18bcf039f464c2ab6cfb3eb6.jpg',
                        solvedCount: 65,
                      ),
                      ProfilePlatformData(
                        platformImgUrl:
                            'https://res-5.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_170,w_170,f_auto,b_white,q_auto:eco/p1mckvzowm4fzzixscah',
                        solvedCount: 65,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Streaks',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? MediaQuery.of(context).size.height * 0.3
                      : MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Streaks(
                        heading: "Days",
                        subtitle1: "Current",
                        subtitle2: "Maximum",
                        value1: 54,
                        value2: 80,
                      ),
                      Streaks(
                        heading: "Accepted Solutions",
                        subtitle1: "Current",
                        subtitle2: "Maximum",
                        value1: 54,
                        value2: 80,
                      ),
                      Streaks(
                        heading: "Problems",
                        subtitle1: "Solved",
                        subtitle2: "Total",
                        value1: 54,
                        value2: 80,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Acceptance Graph',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AcceptanceGraph(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
