import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stopstalkapp/screens/login/login_screen.dart';
import 'package:stopstalkapp/utils/storage.dart';

import '../screens/leaderboard_screen.dart';
import '../screens/profile.dart';
import '../screens/search_friends_screen.dart';
import '../screens/search_problems_screen.dart';
import '../screens/trending_problems_screen.dart';
import '../screens/upcoming_contest_screen.dart';
// import '../screens/user_editorials.dart';
import '../screens/dashboard.dart';
import '../screens/todoList_screen.dart';
import '../screens/developers_info.dart';
import '../classes/leaderboard.dart';
import '../classes/dashboard_class.dart';
import '../classes/trendingProblems_class.dart';

import '../utils/auth.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  dynamic _userData;

  void setUser() async {
    var user = await getCurrentUser();
    setState(() => _userData = user);
  }

  @override
  void initState() {
    setUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: _userData != null
                    ? Text(_userData.stopstalkHandle)
                    : Text('Hello User')),
            _userData != null
                ? ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ProfileScreen(
                                  handle: _userData.stopstalkHandle,isUserItself: true,)));
                    },
                  )
                : ListTile(
                    leading: Icon(Icons.person_add),
                    title: Text('Login/Register'),
                    onTap: () {
                      deleteAllDataSecureStore();
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: LoginPage()));
                    },
                  ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.of(context).pushNamed(Dashboard.routeName,
                    arguments: DashboardClass(
                        loggedin: _userData != null ? true : false));
              },
            ),
            Divider(),
            _userData != null
                ? ListTile(
                    leading: Icon(Icons.list),
                    title: Text('ToDo List'),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ToDoListScreen()));
                    },
                  )
                : Container(),
            _userData != null ? Divider() : Container(),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search Friends'),
              onTap: () {
                Navigator.of(context).pushNamed(SearchFriendsScreen.routeName,
                    arguments:_userData != null ? false : true);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Upcoming contests'),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: UpcomingContestScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.find_in_page),
              title: Text('Search Problems'),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: SearchProblemsScreen()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text('LeaderBoard'),
              onTap: () {
                Navigator.of(context).pushNamed(LeaderBoardScreen.routeName,
                    arguments: LeaderBoard(
                        loggedin: _userData != null ? false : true));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.show_chart),
              title: Text('Trending Problems'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  TrendingProblemsScreen.routeName,
                  arguments: TrendingProblems(
                      loggedin: _userData != null ? false : true),
                );
              },
            ),
            Divider(),
            _userData != null
                ? ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () {
                      deleteAllDataSecureStore();
                      Navigator.of(context)
                          .pushReplacementNamed(LoginPage.routeName);
                    },
                  )
                : SizedBox(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: DevelopersInfo()));
              },
              child: Container(
                height: 80.0,
                decoration: BoxDecoration(
                  color: Color(0xFF2542ff),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                ),
                child: Center(
                  child: ListTile(
                    title: Text(
                      "Developer's Info",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    leading: Icon(
                      Icons.info,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
