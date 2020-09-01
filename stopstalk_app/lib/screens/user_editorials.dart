import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/app_drawer.dart';
import '../widgets/preloader.dart';

class UserEditorialScreen extends StatelessWidget {
  static const routeName = '/user-editorial';

  Future<List<UserEditorial>> _getUsers() async {
    String url = "https://www.stopstalk.com/user_editorials.json";
    var data = await http.get(url);
    var jsonData = jsonDecode(data.body);
    List<UserEditorial> users = [];
    for (var user in jsonData["table_rows"]) {
      UserEditorial userEditorial = UserEditorial(
          user[0].toString(), user[1].toString(), user[2], user[3]);
      users.add(userEditorial);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'User Editorials',
            textAlign: TextAlign.center,
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.insert_chart,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                    ),
                    Text(
                      "LEADERBOARD",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.solidEdit,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                    ),
                    Text(
                      "EDITORIALS",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        drawer: AppDrawer(),
        body: TabBarView(
          children: [
            Container(
              child: FutureBuilder(
                future: _getUsers(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Preloader();
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: EdgeInsets.only(
                              left: 10.0, top: 5.0, right: 10.0, bottom: 5.0),
                          shadowColor: Colors.teal,
                          child: ListTile(
                            leading: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "#"+(index+1).toString(),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            title: Text(snapshot.data[index].name),
                            trailing: Container(
                              width: 80.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.solidEdit,
                                          size: 22.0,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 3.0),
                                        ),
                                        Text(
                                          snapshot.data[index].editorial_count,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.thumb_up,
                                          color: Colors.green,
                                        ),
                                        Text(
                                          snapshot.data[index].votes_count,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Text(""),
          ],
        ),
      ),
    );
  }
}

class UserEditorial {
  final String editorial_count;
  final String votes_count;
  final String name;
  final String username;

  UserEditorial(
      this.editorial_count, this.votes_count, this.username, this.name);
}
