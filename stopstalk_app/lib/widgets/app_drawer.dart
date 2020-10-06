import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../screens/leaderboard_screen.dart';
import '../screens/profile.dart';
import '../screens/search_friends_screen.dart';
import '../screens/search_problems_screen.dart';
import '../screens/submission_filters_screen.dart';
import '../screens/testimonials_screen.dart';
import '../screens/trending_problems_screen.dart';
import '../screens/upcoming_contest_screen.dart';
import '../screens/user_editorials.dart';
import '../screens/dashboard.dart';

import '../utils/auth.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: FutureBuilder(
                  future: getCurrentUser(),
                  builder: (ctx, snapshot) {
                    if (snapshot.data != null) {
                      return Text(snapshot.data.stopstalk_handle);
                    }
                    return Text('Hello User');
                  }),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ProfileScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(Dashboard.routeName);
              },
            ),
            Divider(),
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
                Navigator.of(context)
                    .pushReplacementNamed(LeaderBoardScreen.routeName);
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
              leading: Icon(Icons.sort),
              title: Text('Submission Filters'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(SubmissionFiltersScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Testimonials'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(TestimonialsScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
