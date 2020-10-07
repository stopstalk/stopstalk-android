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
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextStyle get titleTextStyle => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                          : MediaQuery.of(context).size.height * 0.2,
                    ),
                    Positioned(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? MediaQuery.of(context).size.height * 0.2
                            : MediaQuery.of(context).size.height * 0.12,
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
                      top: MediaQuery.of(context).size.height * 0.03,
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          AppDrawer();
                          scaffoldKey.currentState.openDrawer();
                        },
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? MediaQuery.of(context).size.height * 0.075
                          : MediaQuery.of(context).size.height * 0.07,
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
                                  SvgPicture.asset(
                                    'assets/flags/in.svg',
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
                            'assets/platform_logos/codeforces_small.png',
                        solvedCount: 65,
                      ),
                      ProfilePlatformData(
                        platformImgUrl:
                            'assets/platform_logos/codechef_small.png',
                        solvedCount: 65,
                      ),
                      ProfilePlatformData(
                        platformImgUrl: 'assets/platform_logos/spoj_small.png',
                        solvedCount: 65,
                      ),
                      ProfilePlatformData(
                        platformImgUrl:
                            'assets/platform_logos/atcoder_small.png',
                        solvedCount: 65,
                      ),
                      ProfilePlatformData(
                        platformImgUrl:
                            'assets/platform_logos/hackerearth_small.png',
                        solvedCount: 65,
                      ),
                      ProfilePlatformData(
                        platformImgUrl:
                            'assets/platform_logos/hackerrank_small.png',
                        solvedCount: 65,
                      ),
                      ProfilePlatformData(
                        platformImgUrl: 'assets/platform_logos/uva_small.png',
                        solvedCount: 65,
                      ),
                      ProfilePlatformData(
                        platformImgUrl: 'assets/platform_logos/timus_small.png',
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
