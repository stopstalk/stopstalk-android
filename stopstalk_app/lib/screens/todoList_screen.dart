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

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<ToDoList> todos = [];
  bool flag = false;
  ToDoList deletedToDo;
  Tween<Offset> _offSetTween = Tween(
    begin: Offset(1, 0),
    end: Offset.zero,
  );
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();

  Future<List<ToDoList>> _getToDoList() async {
    for (int i = 1; i < 5; i++) {
      if (i % 2 == 0) {
        ToDoList todo = ToDoList(
          problemName: 'Two Arrays',
          platform: 'Codechef',
          totalSubmissions: (i * 500).toString(),
          totalUsers: (i * 600).toString(),
          isChecked: false,
        );
        todos.add(todo);
      } else {
        ToDoList todo = ToDoList(
          problemName: 'Floor Number',
          platform: 'Codeforces',
          totalSubmissions: (i * 100).toString(),
          totalUsers: (i * 300).toString(),
          isChecked: false,
        );
        todos.add(todo);
      }
    }
    todos.length == 0 ? flag = true : flag = false;
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
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            tooltip: "Delete All",
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Confirmation"),
                content: Text("Are you sure you wish to delete all the items"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _deleteAll();
                      Navigator.of(context).pop();
                    },
                    child: const Text("DELETE ALL"),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, right: 0.0, left: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Problem',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    //Text(''),
                    Text(
                      "Platform",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    //SizedBox(),
                    Text(
                      'Count',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Total Users',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: myFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: flag != true
                          ? AnimatedList(
                              key: _animatedListKey,
                              primary: true,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              initialItemCount: snapshot.data.length,
                              itemBuilder: (context, i, animation) {
                                return buildToDoItem(
                                    snapshot.data[i], context, i, animation);
                              },
                            )
                          : _showAllComplete(),
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

  Widget buildToDoItem(ToDoList todo, BuildContext context, int i, animation) {
    return GestureDetector(
      onLongPress: _launchURL,
      child: FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: _offSetTween.animate(animation),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
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
                  Checkbox(
                      value: todo.isChecked,
                      onChanged: (newValue) {
                        setState(() {
                          todo.isChecked = newValue;
                          _deleteTodo(i, context);
                        });
                      }),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
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
        ),
      ),
    );
  }

  void _deleteTodo(int i, BuildContext context) {
    deletedToDo = todos[i];
    _animatedListKey.currentState.removeItem(
      i,
      (BuildContext context, Animation<double> animation) {
        return FadeTransition(
          opacity:
              CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
          child: SizeTransition(
            sizeFactor:
                CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
            axisAlignment: 0.0,
            child: buildToDoItem(deletedToDo, context, i, animation),
          ),
        );
      },
      duration: Duration(milliseconds: 600),
    );
    setState(() {
      todos.removeAt(i);
    });
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Todo ${i + 1} is completed"),
      elevation: 10,
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () => setState(() {
          todos.insert(i, deletedToDo);
          _animatedListKey.currentState
              .insertItem(i, duration: Duration(milliseconds: 500));
          deletedToDo.isChecked = false;
          flag = false;
        }),
      ),
    ));
    if (todos.length == 0) {
      flag = true;
    }
  }

  _deleteAll() {
    int initialLength = todos.length;
    for (int i = 0; i < initialLength; i++) {
      deletedToDo = todos[0];
      _animatedListKey.currentState.removeItem(
        0,
        (BuildContext context, Animation<double> animation) {
          return FadeTransition(
            opacity:
                CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
            child: SizeTransition(
              sizeFactor:
                  CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
              axisAlignment: 0.0,
              child: buildToDoItem(deletedToDo, context, 0, animation),
            ),
          );
        },
        duration: Duration(milliseconds: 600),
      );
      setState(() {
        todos.removeAt(0);
      });
    }
    flag = true;
  }

  Widget _showAllComplete() {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(milliseconds: 600),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/todosDone.jpg',
              width: 150,
              height: 150,
            ),
            Text(
              'All tasks completed!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
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
