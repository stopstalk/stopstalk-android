import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopstalkapp/widgets/search_friends/cards.dart';
import 'package:stopstalkapp/widgets/search_friends/search_bar.dart';

import '../widgets/app_drawer.dart';

class SearchFriendsScreen extends StatelessWidget {
  static const routeName = '/search-friends';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Friends',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          SearchBar(),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Cards(),
                  Cards(),
                  Cards(),
                  Cards(),
                  Cards(),
                  Cards(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
