import 'package:flutter/material.dart';
import 'package:stopstalkapp/screens/leaderboard_screen.dart';
import 'package:stopstalkapp/screens/profile.dart';
import 'package:stopstalkapp/screens/search_friends_screen.dart';
import 'package:stopstalkapp/screens/search_problems_screen.dart';
import 'package:stopstalkapp/screens/submission_filters_screen.dart';
import 'package:stopstalkapp/screens/testimonials_screen.dart';
import 'package:stopstalkapp/screens/trending_problems_screen.dart';
import 'package:stopstalkapp/screens/upcoming_contest_screen.dart';
import 'package:stopstalkapp/screens/user_editorials.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Hello User'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('User Editorials'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(UserEditorialScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search Friends'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(SearchFriendsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Upcoming contests'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(UpcomingContestScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.find_in_page),
              title: Text('Search Problems'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(SearchProblemsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text('LeaderBoard'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(LeaderBoardScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.show_chart),
              title: Text('Trending Problems'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(TrendingProblemsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.sort),
              title: Text('Submission Filters'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(SubmissionFiltersScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Testimonials'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(TestimonialsScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
