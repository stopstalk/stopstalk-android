import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/app_drawer.dart';
import '../classes/todoList_class.dart';

class ToDoListScreen extends StatefulWidget {
  static const routeName = '/todoList';

  static const platformImgs = {
    'Codechef': 'assets/platform_logos/codechef_small.png',
    'Codeforces': 'assets/platform_logos/codeforces_small.png',
    'Spoj': 'assets/platform_logos/spoj_small.png',
    'Atcoder': 'assets/platform_logos/atcoder_small.png',
    'Hackerearth': 'assets/platform_logos/hackerearth_small.png',
    'Hackerrank': 'assets/platform_logos/hackerrank_small.png',
    'Uva': 'assets/platform_logos/uva_small.png',
    'Timus': 'assets/platform_logos/timus_small.png',
  };

  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

List<ToDoList> todos = [];

class _ToDoListScreenState extends State<ToDoListScreen> {
  Future<List<ToDoList>> _getToDoList() async {
    for (int i = 1; i < 6; i++) {
      if (i % 2 == 0) {
        ToDoList todo = ToDoList(
          problemName: 'Aditiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
          platform: 'Codechef',
          totalSubmissions: i.toString(),
          totalUsers: i.toString(),
        );
        todos.add(todo);
      } else {
        ToDoList todo = ToDoList(
          problemName: 'Aditi',
          platform: 'Codeforces',
          totalSubmissions: (i * 100).toString(),
          totalUsers: i.toString(),
        );
        todos.add(todo);
      }
    }
    print(todos.length);
    return todos;
  }

  Future<List<ToDoList>> myFuture;

  @override
  void initState() {
    myFuture = _getToDoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ToDo List',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Problem Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Platform",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Submissions',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Total Users',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: myFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.95,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return buildToDoItem(snapshot.data[i], context, i);
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error);
                  } else {
                    return Text('no error and no data');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildToDoItem(ToDoList todo, BuildContext context, int i) {
    return todos.length > 2
        ? Dismissible(
            key: UniqueKey(),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                todos.removeAt(i);
                if (todos.length == 1) {
                  setState(() {
                    Text('No todos');
                  });
                }
              });
              print(todos.length);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Todo ${i + 1} is completed"),
                  duration: Duration(milliseconds: 5),
                ),
              );
            },
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirmation"),
                    content: Text(
                        "Are you sure you wish to delete todo item ${i + 1}"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("DELETE"),
                      ),
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("CANCEL"),
                      ),
                    ],
                  );
                },
              );
            },
            child: GestureDetector(
              onTap: _launchURL,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                color: Color(0XFFeeeeee),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              todo.problemName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Image.asset(
                            ToDoListScreen.platformImgs[todo.platform],
                            height: 80,
                            width: 60,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(todo.totalSubmissions),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(todo.totalUsers),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Text('No todos at the end');
  }

  _launchURL() async {
    const url = 'https://www.stopstalk.com/problems?problem_id=70';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
