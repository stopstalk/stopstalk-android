import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/app_drawer.dart';
import '../widgets/preloader.dart';
import '../classes/todoList_class.dart';
import '../utils/api.dart';
import '../utils/platforms.dart' as platforms;
import '../screens/search_problems_screen.dart';

class ToDoListScreen extends StatefulWidget {
  static const routeName = '/todoList';
  static const platformImgs = platforms.platformImgs;

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
    var probs = await getTodos(context);
    if (probs == null) return [];
    List todosFetched = probs['todos'];
    todosFetched.forEach((element) {
      ToDoList todo = ToDoList(
        id: element['id'].toString(),
        link: element['link'],
        problemName: element['name'],
        platform: element['platform'].toLowerCase(),
        totalSubmissions: element['total_submissions'].toString(),
        totalUsers: element['user_ids'].split(',').length.toString(),
        isChecked: false,
      );
      todos.add(todo);
    });
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
              builder: (context) => flag != true
                  ? AlertDialog(
                      title: const Text("Confirmation"),
                      content:
                          Text("Are you sure you wish to delete all the items"),
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
                    )
                  : AlertDialog(
                      title: const Text("Confirmation"),
                      content: Text("All tasks are completed."),
                    ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: myFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Preloader();
            } else {
              return Container(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  physics: flag == true
                      ? NeverScrollableScrollPhysics()
                      : BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      flag != true
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, right: 0.0, left: 50),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                            )
                          : Container(),
                      Container(
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
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  Widget buildToDoItem(ToDoList todo, BuildContext context, int i, animation) {
    return FadeTransition(
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
                        child: InkWell(
                            child: Text(
                              todo.problemName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () => _launchURL(
                                "https://www.stopstalk.com/problems?problem_id=${todo.id}")),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      todo.platform != null &&
                              ToDoListScreen.platformImgs[todo.platform] != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: GestureDetector(
                                onTap: () {
                                  _launchURL(todo.link);
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xFF2542ff),
                                  child: CircleAvatar(
                                    backgroundColor: Color(0XFFeeeeee),
                                    radius: 28,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(22),
                                        child: Image.asset(
                                          ToDoListScreen
                                              .platformImgs[todo.platform],
                                          height: 80,
                                          width: 60,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          : SizedBox(height: 80, width: 60),
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
          if (_animatedListKey.currentState != null) {
            _animatedListKey.currentState
                .insertItem(i, duration: Duration(milliseconds: 500));
          }
          deletedToDo.isChecked = false;
          flag = false;
        }),
      ),
    ));
    Future.delayed(const Duration(seconds: 3), () {
      if (deletedToDo.isChecked) {
        _senddelrequest(deletedToDo.link, context);
      }
    });
    if (todos.length == 0) {
      flag = true;
    }
  }

  _deleteAll() {
    int initialLength = todos.length;
    for (int i = 0; i < initialLength; i++) {
      _senddelrequest(todos[0].link, context);
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
              'assets/images/todosDone.png',
              width: 150,
              height: 150,
            ),
            Text(
              'All tasks completed!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            RaisedButton(
              elevation: 4,
              onPressed: () {
                Navigator.of(context).pushNamed(SearchProblemsScreen.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add more Todo problems",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

_senddelrequest(String link, BuildContext context) async {
  deleteTodoUsingLink(link, context);
}
