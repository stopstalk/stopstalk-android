import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:folding_cell/folding_cell.dart';
import 'package:flag/flag.dart';

import '../widgets/app_drawer.dart';
import '../classes/leaderboard.dart';
import '../widgets/preloader.dart';

class LeaderBoardScreen extends StatelessWidget {
  static const routeName = '/leaderBoard';

  TextStyle get titleTextStyle => TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 12,
    height: 1,
    letterSpacing: .2,
    fontWeight: FontWeight.w800,
    color: Color(0xffafaabf),
  );

  TextStyle get contentTextStyle => TextStyle(
    fontFamily: 'Oswald',
    fontSize: 20,
    height: 1.8,
    letterSpacing: .3,
    color: Color(0xff083e64),
  );

  Future<List<LeaderBoard>> _getLeaderBoard() async {
    const url = "https://www.stopstalk.com/leaderboard.json";
    final response = await http.get(url);
    final jsonData = jsonDecode(response.body);
    List<LeaderBoard> users = [];
    for (var user in jsonData["users"]) {
      LeaderBoard person = LeaderBoard(
        name: user[0],
        stopstalkHandle: user[1],
        institute: user[2],
        stopstalkRating: user[3],
        perDayChanges: user[4],
        country: user[5],
        customUsers: user[6],
        rank: user[7],
      );
      users.add(person);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'LeaderBoard',
            textAlign: TextAlign.center,
          ),
          bottom: TabBar(tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.language),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'GLOBAL',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'FRIENDS',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
        drawer: AppDrawer(),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: FutureBuilder(
                        future: _getLeaderBoard(),
                        builder: (ctx, snapshot) {
                          if (!snapshot.hasData) {
                            return Preloader();
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (ctx, i) {
                                return Container(
                                  child: SimpleFoldingCell(
                                    frontWidget: _buildFrontWidget(
                                      i,
                                      snapshot.data[i].name,
                                      snapshot.data[i].institute,
                                    ),
                                    innerTopWidget: _buildInnerTopWidget(
                                      snapshot.data[i].name,
                                      snapshot.data[i].stopstalkHandle,
                                      titleTextStyle,
                                      contentTextStyle,
                                      snapshot.data[i].country != null
                                          ? snapshot.data[i].country[0]
                                          : 'NA',
                                    ),
                                    innerBottomWidget: _buildInnerBottomWidget(
                                      snapshot.data[i].institute,
                                      snapshot.data[i].country != null
                                          ? snapshot.data[i].country[1]
                                          : 'NA',
                                      snapshot.data[i].stopstalkRating,
                                      snapshot.data[i].perDayChanges,
                                      snapshot.data[i].customUsers,
                                      titleTextStyle,
                                      contentTextStyle,
                                    ),
                                    cellSize: Size(
                                        MediaQuery.of(context).size.width, 175),
                                    padding: EdgeInsets.all(15),
                                    animationDuration:
                                    Duration(milliseconds: 300),
                                    borderRadius: 10,
                                    onOpen: () => print('$i cell opened'),
                                    onClose: () => print('$i cell closed'),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Text('this is the friends leaderboard page'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrontWidget(int index, String name, String institute) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.lightBlueAccent.shade100,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '#${index + 1}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.indigo.shade50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$name',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          //fontFamily: 'Oswald',
                          fontSize: 25,
                          height: 1.8,
                          letterSpacing: .3,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff083e64),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.school,
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              institute,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                //fontFamily: 'Oswald',
                                fontSize: 15,
                                height: 1.8,
                                letterSpacing: .3,
                                color: Color(0xff083e64),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      IconButton(
                        onPressed: () {
                          final foldingCellState =
                          context.findAncestorStateOfType<
                              SimpleFoldingCellState>();
                          foldingCellState?.toggleFold();
                        },
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInnerTopWidget(
      String name,
      String handle,
      TextStyle titleTextStyle,
      TextStyle contentTextStyle,
      String countryCode) {
    return Container(
      color: Colors.lightBlueAccent.shade100,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Name'.toUpperCase(),
                    style: titleTextStyle,
                  ),
                  Text(
                    name,
                    style: contentTextStyle,
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Flag(
                countryCode,
                height: 40,
                fit: BoxFit.fill,
                width: 60,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Handle'.toUpperCase(),
                    style: titleTextStyle,
                  ),
                  Text(
                    handle,
                    style: contentTextStyle,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: FlatButton(
                      onPressed: null,
                      child: Text(''
                          'Visit Profile'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInnerBottomWidget(
      String institute,
      String country,
      int rating,
      double perDayChanges,
      int customUsers,
      TextStyle titleTextStyle,
      TextStyle contentTextStyle) {
    return Container(
      color: Colors.indigo.shade50,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex:2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Institute'.toUpperCase(),
                        style: titleTextStyle,
                      ),
                      Text(
                        institute,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: contentTextStyle,
                      ),
                    ],
                  ),
                ),
                //SizedBox(width: 15,),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Country'.toUpperCase(),
                        style: titleTextStyle,
                      ),
                      Text(
                        country,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: contentTextStyle,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'StopStalk Rating'.toUpperCase(),
                    style: titleTextStyle,
                  ),
                  Text(
                    rating.toString(),
                    style: contentTextStyle,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Per Day Changes'.toUpperCase(),
                    style: titleTextStyle,
                  ),
                  Row(
                    children: [
                      perDayChanges < 0
                          ? Icon(
                        Icons.arrow_drop_down,
                        size: 35,
                        color: Colors.red,
                      )
                          : Icon(
                        Icons.arrow_drop_up,
                        size: 35,
                        color: Colors.green,
                      ),
                      Text(
                        perDayChanges.toStringAsPrecision(5),
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 20,
                          height: 1.8,
                          letterSpacing: .3,
                          color: perDayChanges < 0 ? Colors.red : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Custom Users'.toUpperCase(),
                    style: titleTextStyle,
                  ),
                  Text(
                    customUsers.toString(),
                    style: contentTextStyle,
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 10,
          ),
          SizedBox(
            height: 29,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Builder(
                  builder: (context) {
                    return IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.keyboard_arrow_up,
                        size: 30,
                      ),
                      onPressed: () {
                        final foldingCellState = context
                            .findAncestorStateOfType<SimpleFoldingCellState>();
                        foldingCellState?.toggleFold();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
