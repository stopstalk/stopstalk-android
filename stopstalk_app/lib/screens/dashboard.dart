import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/dashboard/upcoming_contests.dart';
import '../widgets/dashboard/add_friends.dart';
import '../widgets/dashboard/link_atcoder.dart';
import '../widgets/dashboard/recent_friend_submissions.dart';
import '../widgets/dashboard/looking_for_jobs.dart';
import '../widgets/dashboard/new_problems_to_solve.dart';
import '../widgets/dashboard/trending_problems.dart';
import '../widgets/dashboard/mood.dart';
import '../widgets/dashboard/pick_a_tag.dart';

class Dashboard extends StatelessWidget {
  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
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
        child: Column(
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
                LinkAtCoder(),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                RecentFriendSubmissions(),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                LookingForJobs(),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                NewProblemsToSolve(),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                TrendingProblems(),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                Mood(),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                PickATag(),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
