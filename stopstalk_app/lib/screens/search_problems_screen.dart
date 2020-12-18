import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../widgets/app_drawer.dart';
import '../screens/searched_problems_screen.dart';

import '../utils/api.dart';

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

  Future<List> _initProblemTags() async {
    final List<Map<String, dynamic>> problemTags = new List();
    var tags = await getSearchProblems({});
    if (tags == null) return [];
    List res = tags['generalized_tags'];
    res.forEach((tag) => problemTags.add({
          "display": tag,
          "value": tag,
        }));
    return problemTags;
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
        padding:
            EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0, bottom: 8.0),
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
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                        borderRadius: BorderRadius.circular(8),
                      ),
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
                    style: TextStyle(fontSize: 16.0),
                  ),
                  FutureBuilder(
                      future: _initProblemTags(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return SizedBox();
                        }
                        return MultiSelectFormField(
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
                          dataSource: snapshot.data,
                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCEL',
                          fillColor: Color(0xffeeeeee),
                        );
                      }),
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
                          excludeMySolvedProblems = !excludeMySolvedProblems;
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
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8),
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
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SearchedProblemsScreen(parameters: {
                                  'name': "pp",
                                  'site': "CodeChef",
                                  'orderby': '',
                                  'generalized_tags': '',
                                  'q': '',
                                  'include_editorials': '',
                                  'exclude_solved': '',
                                });
                              }));
                            }),
                      ),
                    ],
                  ),
                ])),
      ),
    );
  }
}
