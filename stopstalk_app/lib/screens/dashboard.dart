import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/dashboard/upcoming_contests.dart';
import '../widgets/dashboard/add_friends.dart';
import '../widgets/dashboard/recent_friend_submissions.dart';
import '../widgets/dashboard/new_problems_to_solve.dart';
import '../widgets/dashboard/trending_problems.dart';
import '../widgets/dashboard/search_problems.dart';
import '../classes/dashboard_class.dart';
import './login/login_screen.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final DashboardClass args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xFF2542ff),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: args.loggedin
            ? Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      UpcomingContests(),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      AddFriends(),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      RecentFriendSubmissions(),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      NewProblemsToSolve(),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      TrendingProblemsDashboard(),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      SearchProblems(),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  )
                ],
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/images/unauthorisedUser.png'),
                    ),
                    Text(
                      "Log in to view Dashboard",
                      style: TextStyle(
                        color: Color(0xFF2542ff),
                        fontSize: 16.0
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.0),
                    ),
                    RaisedButton(
                      elevation: 4,
                      color: Theme.of(context).buttonColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          args.loggedin
                              ? "You are now logged in"
                              : "Sign In to StopStalk",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginPage.routeName);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
