import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class UpcomingContestScreen extends StatelessWidget {
  static const routeName = '/upcoming-contests';

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
        child: Text('This is the upcoming contests page'),
      ),
    );
  }
}
