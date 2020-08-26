import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class SearchFriendsScreen extends StatelessWidget {
  static const routeName = '/search-friends';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'StopStalk',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('This is the search friends page'),
      ),
    );
  }
}
