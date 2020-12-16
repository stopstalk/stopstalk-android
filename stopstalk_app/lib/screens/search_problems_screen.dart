import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../widgets/app_drawer.dart';
import'../screens/searched_problems_screen.dart';

class SearchProblemsScreen extends StatefulWidget {
  SearchProblemsScreen({Key key}) : super(key: key);
  static const routeName = '/search-problems';

  @override
  _SearchProblemsScreenState createState() => _SearchProblemsScreenState();
}

class _SearchProblemsScreenState extends State<SearchProblemsScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<DropdownMenuItem> sites = new List();
  final List<DropdownMenuItem> sortBy = new List();
  final List<DropdownMenuItem> problemTags = new List();

  String selectedSortBy = "accasc";
  String selectedSite = "CodeChef";
  String selectedProblemTagDropdown = "dummy1";
  String selectedProblemTagTextbox = "";

  bool onlyShowProblemsWithEditorials = false;
  bool excludeMySolvedProblems = false;

  @override
  void initState() {
    super.initState();
    _initSites();
    _initSortBy();
    _initProblemTags();
  }

  void _initSites() {
    sites.addAll([
      DropdownMenuItem(
          value: "CodeChef", child: Text("CodeChef"), key: Key("CodeChef")),
      DropdownMenuItem(
          value: "CodeForces",
          child: Text("CodeForces"),
          key: Key("CodeForces")),
      DropdownMenuItem(value: "SPOJ", child: Text("SPOJ"), key: Key("SPOJ")),
      DropdownMenuItem(
          value: "AtCoder", child: Text("AtCoder"), key: Key("AtCoder")),
      DropdownMenuItem(
          value: "HackerEarth",
          child: Text("HackerEarth"),
          key: Key("HackerEarth")),
      DropdownMenuItem(
          value: "HackerRank",
          child: Text("HackerRank"),
          key: Key("HackerRank")),
      DropdownMenuItem(value: "UVa", child: Text("UVa"), key: Key("UVa")),
      DropdownMenuItem(value: "Timus", child: Text("Timus"), key: Key("Timus")),
    ]);
  }

  void _initSortBy() {
    sortBy.addAll([
      DropdownMenuItem(
          value: "accasc",
          child: Text("Accuracy (Ascending)"),
          key: Key("accasc")),
      DropdownMenuItem(
          value: "accdesc",
          child: Text("Accuracy (Descending)"),
          key: Key("accdesc")),
      DropdownMenuItem(
          value: "solcntasc",
          child: Text("Solved Count (Ascending)"),
          key: Key("solcntasc")),
      DropdownMenuItem(
          value: "solcntdesc",
          child: Text("Solved Count (Descending)"),
          key: Key("solcntdesc")),
    ]);
  }

  void _initProblemTags() {
    problemTags.addAll([
      DropdownMenuItem(
          value: "dummy1", child: Text("dummy"), key: Key("dummy1")),
      DropdownMenuItem(
          value: "dummy2", child: Text("dummy"), key: Key("dummy2")),
      DropdownMenuItem(
          value: "dummy3", child: Text("dummy"), key: Key("dummy3")),
      DropdownMenuItem(
          value: "dummy4", child: Text("dummy"), key: Key("dummy4")),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Problems',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xFF2542ff),
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0, bottom: 8.0),
        child: Form(
            key: _formKey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Color(0xffeeeeee))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffeeeeee))),
                      hintText: "Problem Name",
                      fillColor: Color(0xffeeeeee),
                      filled: true,
                      hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                  ),
                  ButtonTheme(
                    alignedDropdown: true,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffeeeeee),
                        borderRadius: BorderRadius.circular(8),),
                      child: DropdownButton(
                        items: sites,
                        value: selectedSite,
                        onChanged: (value) {
                          selectedSite = value;
                          setState(() {});
                        },
                        hint: Text("Site"),
                        isExpanded: true,
                        dropdownColor: Color(0xffeeeeee),
                        underline: Container(
                          color: Color(0xffeeeeee),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                  ),
                  ButtonTheme(
                    alignedDropdown: true,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffeeeeee),
                        borderRadius: BorderRadius.circular(8),),
                      child: DropdownButton(
                        items: sortBy,
                        value: selectedSortBy,
                        onChanged: (value) {
                          selectedSortBy = value;
                          setState(() {});
                        },
                        hint: Text("Sort By"),
                        isExpanded: true,
                        dropdownColor: Color(0xffeeeeee),
                        underline: Container(
                          color: Color(0xffeeeeee),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Color(0xffeeeeee))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffeeeeee))),
                      hintText: "Search Site Tags",
                      fillColor: Color(0xffeeeeee),
                      filled: true,
                      hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                  ),
                  Text(
                    "or",
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontSize: 16.0),
                  ),
                  MultiSelectFormField(
                    title: Text(
                      "Generalised StopStalk Tags",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400),
                    ),
                    hintWidget: null,
                    checkBoxActiveColor: Color(0xFF2542ff),
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'Please select one or more options';
                      }
                      return '';
                    },
                    dataSource: [
                      {
                        "display": "Ad-hoc",
                        "value": "Ad-hoc",
                      },
                      {
                        "display": "Array",
                        "value": "Array",
                      },
                      {
                        "display": "Artificial Intelligence",
                        "value": "Artificial Intelligence",
                      },
                      {
                        "display": "Backtracking",
                        "value": "Backtracking",
                      },
                      {
                        "display": "Binary Indexed Tree",
                        "value": "Binary Indexed Tree",
                      },
                      {
                        "display": "Binary Search",
                        "value": "Binary Search",
                      },
                      {
                        "display": "Binary Search Tree",
                        "value": "Binary Search Tree",
                      },
                      {
                        "display": "Binary Tree",
                        "value": "Binary Tree",
                      },
                      {
                        "display": "Bit Manipulation",
                        "value": "Bit Manipulation",
                      },
                      {
                        "display": "Bitmasks",
                        "value": "Bitmasks",
                      },
                      {
                        "display": "Breadth First Search",
                        "value": "Breadth First Search",
                      },
                      {
                        "display": "Brute Force",
                        "value": "Brute Force",
                      },
                      {
                        "display": "Combinatorics",
                        "value": "Combinatorics",
                      },
                      {
                        "display": "Constructive Algorithms",
                        "value": "Constructive Algorithms",
                      },
                      {
                        "display": "Convex Hull",
                        "value": "Convex Hull",
                      },
                      {
                        "display": "Data Structures",
                        "value": "Data Structures",
                      },
                      {
                        "display": "Depth First Search",
                        "value": "Depth First Search",
                      },
                      {
                        "display": "Disjoint Set Union",
                        "value": "Disjoint Set Union",
                      },
                      {
                        "display": "Divide and Conquer",
                        "value": "Divide and Conquer",
                      },
                      {
                        "display": "Dynamic Programming",
                        "value": "Dynamic Programming",
                      },
                      {
                        "display": "Easy",
                        "value": "Easy",
                      },
                      {
                        "display": "Functional Programming",
                        "value": "Functional Programming",
                      },
                      {
                        "display": "Game Theory",
                        "value": "Game Theory",
                      },
                      {
                        "display": "Geometry",
                        "value": "Geometry",
                      },
                      {
                        "display": "Graph",
                        "value": "Graph",
                      },
                      {
                        "display": "Graph Coloring",
                        "value": "Graph Coloring",
                      },
                      {
                        "display": "Greedy",
                        "value": "Greedy",
                      },
                      {
                        "display": "Hard",
                        "value": "Hard",
                      },
                      {
                        "display": "Hashing",
                        "value": "Hashing",
                      },
                      {
                        "display": "Heap",
                        "value": "Heap",
                      },
                      {
                        "display": "Implementation",
                        "value": "Implementation",
                      },
                      {
                        "display": "Linked List",
                        "value": "Linked List",
                      },
                      {
                        "display": "Math",
                        "value": "Math",
                      },
                      {
                        "display": "Matrix Exponentiation",
                        "value": "Matrix Exponentiation",
                      },
                      {
                        "display": "Medium",
                        "value": "Medium",
                      },
                      {
                        "display": "Minimum Spanning Tree",
                        "value": "Minimum Spanning Tree",
                      },
                      {
                        "display": "Number Theory",
                        "value": "Number Theory",
                      },
                      {
                        "display": "Priority Queue",
                        "value": "Priority Queue",
                      },
                      {
                        "display": "Probability",
                        "value": "Probability",
                      },
                      {
                        "display": "Queues",
                        "value": "Queues",
                      },
                      {
                        "display": "Recursion",
                        "value": "Recursion",
                      },
                      {
                        "display": "Segment Tree",
                        "value": "Segment Tree",
                      },
                      {
                        "display": "Shortest Path",
                        "value": "Shortest Path",
                      },
                      {
                        "display": "Sieve",
                        "value": "Sieve",
                      },
                      {
                        "display": "Sorting",
                        "value": "Sorting",
                      },
                      {
                        "display": "Square Root Decomposition",
                        "value": "Square Root Decomposition",
                      },
                      {
                        "display": "Stacks",
                        "value": "Stacks",
                      },
                      {
                        "display": "String",
                        "value": "String",
                      },
                      {
                        "display": "Ternary Search",
                        "value": "Ternary Search",
                      },
                      {
                        "display": "Topological Sort",
                        "value": "Topological Sort",
                      },
                      {
                        "display": "Tree",
                        "value": "Tree",
                      },
                      {
                        "display": "Trie",
                        "value": "Trie",
                      },
                      {
                        "display": "Two Pointers",
                        "value": "Two Pointers",
                      },
                      {
                        "display": "Vertex Cover",
                        "value": "Vertex Cover",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    fillColor: Color(0xffeeeeee),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                  ),
                  ListTile(
                    leading: Checkbox(
                      value: onlyShowProblemsWithEditorials,
                      onChanged: (value) {
                        onlyShowProblemsWithEditorials = value;
                        setState(() {});
                      },
                      activeColor: Color(0xFF2542ff),
                    ),
                    title: InkWell(
                        onTap: () {
                          onlyShowProblemsWithEditorials =
                          !onlyShowProblemsWithEditorials;
                          setState(() {});
                        },
                        child: Text("Only show problems with Editorials")),
                  ),
                  ListTile(
                    leading: Checkbox(
                      value: excludeMySolvedProblems,
                      onChanged: (value) {
                        excludeMySolvedProblems = value;
                        setState(() {});
                      },
                      activeColor: Color(0xFF2542ff),
                    ),
                    // title: Text("Exclude my Solved Problems"),
                    title: InkWell(
                        onTap: () {
                          excludeMySolvedProblems =
                          !excludeMySolvedProblems;
                          setState(() {});
                        },
                        child: Text("Exclude my Solved Problems")),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120.0,
                        child: RaisedButton(
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: Color(0xFF2542ff),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 20,
                              ),
                              AutoSizeText(
                                ' Search',
                                maxLines: 1,
                                minFontSize: 7,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SearchedProblemsScreen.routeName);}
                        ),
                      ),
                    ],
                  ),
                ])),
      ),
    );
  }
}