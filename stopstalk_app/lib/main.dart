import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

import './screens/profile.dart';
import './screens/leaderboard_screen.dart';
import './screens/search_friends_screen.dart';
import './screens/search_problems_screen.dart';
import './screens/submission_filters_screen.dart';
import './screens/testimonials_screen.dart';
import './screens/trending_problems_screen.dart';
import './screens/upcoming_contest_screen.dart';
import './screens/login/login_screen.dart';
import './screens/user_editorials.dart';
import './screens/dashboard.dart';
import './screens/todoList_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  FlutterConfig.variables.forEach((k, v) {
    print('$k: $v');
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopStalk App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: {
        LoginPage.routeName: (ctx) => LoginPage(),
        Dashboard.routeName: (ctx) => Dashboard(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        ToDoListScreen.routeName:(ctx)=>ToDoListScreen(),
        UserEditorialScreen.routeName: (ctx) => UserEditorialScreen(),
        SearchFriendsScreen.routeName: (ctx) => SearchFriendsScreen(),
        UpcomingContestScreen.routeName: (ctx) => UpcomingContestScreen(),
        SearchProblemsScreen.routeName: (ctx) => SearchProblemsScreen(),
        LeaderBoardScreen.routeName: (ctx) => LeaderBoardScreen(),
        TrendingProblemsScreen.routeName: (ctx) => TrendingProblemsScreen(),
        SubmissionFiltersScreen.routeName: (ctx) => SubmissionFiltersScreen(),
        TestimonialsScreen.routeName: (ctx) => TestimonialsScreen(),
      },
    );
  }
}
