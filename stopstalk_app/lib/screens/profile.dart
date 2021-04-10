import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stopstalkapp/classes/searched_friends_class.dart';

import '../classes/user.dart';
import '../utils/auth.dart';
import '../utils/api.dart';
import '../widgets/app_drawer.dart';
import '../widgets/streaks_profile.dart';
import '../widgets/platform_data_profile.dart';
import '../widgets/acceptance_graph.dart';
import '../widgets/preloader.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Friends friend;
  final String handle;
  final bool isUserItself;

  ProfileScreen({Key key, this.handle, this.isUserItself, this.friend})
      : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  bool isFriend = false;

  @override
  void initState() {
    if (widget.isUserItself) {
      isFriend = false;
    } else {
      isFriend = widget.friend.isFriend;
    }
    super.initState();
  }

  TextStyle get titleTextStyle => TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      drawer: AppDrawer(),
      body: Container(
        child: FutureBuilder(
            future: getProfileFromHandle(widget.handle),
            builder: (context, snapshot) {
              if (snapshot.data == null) return Preloader();
              return Stack(
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
                                  widget.scaffoldKey.currentState.openDrawer();
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        //crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            snapshot.data.user.name(),
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
                                              snapshot.data.user.institute,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FutureBuilder(
                                              future:
                                                  snapshot.data.getFlagURL(),
                                              builder: (context, snapshot) {
                                                if (snapshot.data == null)
                                                  return Preloader();
                                                return SvgPicture.asset(
                                                  snapshot.data,
                                                  width: 65,
                                                  height: 45,
                                                );
                                              }),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        snapshot.data.getSitesDetails() != null &&
                                snapshot.data.getSitesDetails().isEmpty == false
                            ? Column(
                                children: [
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
                                    height: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.landscape
                                        ? MediaQuery.of(context).size.height *
                                            0.3
                                        : MediaQuery.of(context).size.height *
                                            0.15,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: listPlatform(
                                            snapshot.data.getSitesDetails())),
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
                                    height: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.landscape
                                        ? MediaQuery.of(context).size.height *
                                            0.3
                                        : MediaQuery.of(context).size.height *
                                            0.15,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        Streaks(
                                          heading: "Days",
                                          subtitle1: "Current",
                                          subtitle2: "Maximum",
                                          value1: snapshot.data.dayCurrent,
                                          value2: snapshot.data.dayMaximum,
                                        ),
                                        Streaks(
                                          heading: "Accepted Solutions",
                                          subtitle1: "Current",
                                          subtitle2: "Maximum",
                                          value1:
                                              snapshot.data.acceptedSolnCurrent,
                                          value2:
                                              snapshot.data.acceptedSolnMaximum,
                                        ),
                                        Streaks(
                                          heading: "Problems",
                                          subtitle1: "Solved",
                                          subtitle2: "Total",
                                          value1: snapshot.data.problemsSolved,
                                          value2: snapshot.data.problemsTotal,
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
                                  AcceptanceGraph(
                                    handle: snapshot.data.user.stopstalkHandle,
                                    graph: snapshot.data.acceptanceGraph != null
                                        ? snapshot.data.acceptanceGraph
                                        : {},
                                  ),
                                ],
                              )
                            : noHandles(snapshot.data.user.stopstalkHandle,
                                widget.isUserItself),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: !widget.isUserItself
          ? Container(
              height: 55.0,
              width: 55.0,
              child: FutureBuilder(
                  //to delay showing the floating button
                  future: getProfileFromHandle(widget.handle),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) return Container();
                    return FloatingActionButton(
                      child: Icon(
                        isFriend
                            ? FontAwesomeIcons.user
                            : FontAwesomeIcons.userPlus,
                      ),
                      backgroundColor: isFriend
                          ? Colors.green
                          : Theme.of(context).buttonColor,
                      onPressed: () async {
                        bool isLoggedin = await isAuthenticated();
                        if (!isLoggedin) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please login to add friends"),
                              elevation: 10,
                              duration: Duration(seconds: 2),
                              action: SnackBarAction(
                                label: 'LOGIN',
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/login');
                                },
                              ),
                            ),
                          );
                        } else {
                          if (!isFriend) {
                            bool friend = await markFriend(
                                snapshot.data.user.id.toString(), context);
                            if (friend) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Added ${snapshot.data.user.stopstalkHandle} to friend list'),
                                    elevation: 10,
                                    duration: Duration(seconds: 2)),
                              );
                              setState(() {
                                isFriend = true;
                              });
                            } else {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Unable to add friend at the moment'),
                                    elevation: 10,
                                    duration: Duration(seconds: 2)),
                              );
                            }
                          } else {
                            bool checkres = await unFriend(
                                snapshot.data.user.id.toString(), context);
                            if (checkres) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Removed ${snapshot.data.user.stopstalkHandle} from friend list'),
                                    elevation: 10,
                                    duration: Duration(seconds: 2)),
                              );
                              setState(() {
                                isFriend = false;
                              });
                            } else {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Unable to remove friend at the moment'),
                                    elevation: 10,
                                    duration: Duration(seconds: 2)),
                              );
                            }
                          }
                        }
                      },
                    );
                  }),
            )
          : Container(),
    );
  }

  Widget noHandles(String stopstalkHandle, bool isUserItself) {
    return Container(
      width: 300,
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(
          isUserItself
              ? 'Please add your competitive coding site handles on the website to view your stats and progress.'
              : '${stopstalkHandle} has not added any competitive coding site handles.',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
