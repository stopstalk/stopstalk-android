import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stopstalkapp/screens/login/login_screen.dart';
import 'package:stopstalkapp/utils/storage.dart';

import '../screens/leaderboard_screen.dart';
import '../screens/profile.dart';
import '../screens/search_friends_screen.dart';
import '../screens/search_problems_screen.dart';
import '../screens/trending_problems_screen.dart';
import '../screens/recommendations_screen.dart';
import '../screens/upcoming_contest_screen.dart';
import '../screens/user_editorials.dart';
import '../screens/dashboard.dart';
import '../screens/todoList_screen.dart';
import '../classes/leaderboard.dart';
import '../classes/dashboard_class.dart';

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
                title: _userData != null
                    ? Text(_userData.stopstalkHandle)
                    : Text('Hello User')),
            _userData != null
                ? ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ProfileScreen(
                                  handle: _userData.stopstalkHandle)));
                    },
                  )
                : ListTile(
                    leading: Icon(Icons.person_add),
                    title: Text('Login/Register'),
                    onTap: () {
                      deleteAllDataSecureStore();
                      Navigator.of(context)
                          .pushReplacementNamed(LoginPage.routeName);
                    },
                  ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Dashboard.routeName,
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
                      Navigator.of(context)
                          .pushReplacementNamed(ToDoListScreen.routeName);
                    },
                  )
                : Container(),
            _userData != null ? Divider() : Container(),
            ListTile(
              leading: Icon(FontAwesomeIcons.solidEdit),
              title: Text('User Editorials'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserEditorialScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search Friends'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(SearchFriendsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Upcoming contests'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UpcomingContestScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.find_in_page),
              title: Text('Search Problems'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(SearchProblemsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text('LeaderBoard'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                    LeaderBoardScreen.routeName,
                    arguments: LeaderBoard(
                        loggedin: _userData != null ? true : false));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.show_chart),
              title: Text('Trending Problems'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(TrendingProblemsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Recommendations'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(RecommendationsScreen.routeName);
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
          ],
        ),
      ),
    );
  }
}
