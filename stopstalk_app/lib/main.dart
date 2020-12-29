import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';

import './screens/profile.dart';
import './screens/leaderboard_screen.dart';
import './screens/search_friends_screen.dart';
import './screens/search_problems_screen.dart';
import './screens/trending_problems_screen.dart';
import './screens/recommendations_screen.dart';
import './screens/upcoming_contest_screen.dart';
import './screens/login/login_screen.dart';

// import './screens/user_editorials.dart';
import './screens/dashboard.dart';
import './screens/todoList_screen.dart';
import './screens/searched_problems_screen.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'StopStalk App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color: Color(0xFF2542ff),
        ),
        buttonColor: Color(0xFF0018ca),
      ),
      home: LoginPage(),
      routes: {
        LoginPage.routeName: (ctx) => LoginPage(),
        Dashboard.routeName: (ctx) => Dashboard(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(
              handle: null,
              isUserItself: null,
            ),
        ToDoListScreen.routeName: (ctx) => ToDoListScreen(),
        // UserEditorialScreen.routeName: (ctx) => UserEditorialScreen(),
        SearchFriendsScreen.routeName: (ctx) => SearchFriendsScreen(),
        UpcomingContestScreen.routeName: (ctx) => UpcomingContestScreen(),
        SearchProblemsScreen.routeName: (ctx) => SearchProblemsScreen(),
        LeaderBoardScreen.routeName: (ctx) => LeaderBoardScreen(),
        TrendingProblemsScreen.routeName: (ctx) => TrendingProblemsScreen(),
        RecommendationsScreen.routeName: (ctx) => RecommendationsScreen(),
        SearchedProblemsScreen.routeName: (ctx) => SearchedProblemsScreen(),
      },
    );
  }
}
