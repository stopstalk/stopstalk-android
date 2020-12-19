import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopstalkapp/widgets/search_friends_card.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../widgets/app_drawer.dart';

import '../classes/searched_friends_class.dart';

import '../utils/api.dart';
import 'dart:async';

class SearchFriendsScreen extends StatefulWidget {
  static const routeName = '/search-friends';

  @override
  _SearchFriendsScreenState createState() => _SearchFriendsScreenState();
}

class _SearchFriendsScreenState extends State<SearchFriendsScreen> {
  bool search = false;
  bool _filterActive = true;
  final searchController = TextEditingController();
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();
  String selectedInstitute, selectedCountry;

  Future<List<List<String>>> myF;

  StreamController _streamController;
  Stream _stream;

  _search() async {
    print("Searching");
    _streamController.add("waiting");
    _getSearchedFriends();
  }

  @override
  void initState() {
    _streamController = StreamController();
    _stream = _streamController.stream;
    _streamController.add("init");
    myF = _getitems();
    super.initState();
  }

  Future<List<List<String>>> _getitems() async {
    var data = await getSearchFriends({'get_list': 'true'});
    if (data == null) return [];
    List<String> inis = [];
    var ini = data["all_institutes"];
    print(inis);
    ini.forEach((e) {
      inis.add(e);
    });

    List<String> conts = [];
    var cont = data["country_name_list"];
    cont.forEach((e) {
      conts.add(e);
    });
    return [inis, conts];
  }

  _getSearchedFriends() async {
    List<Friends> searched = [];
    var data = await getSearchFriends({
      'q': searchController.text,
      'institute': selectedInstitute,
      'country': selectedCountry
    });
    if (data == null) return [];
    var res = data['users'];
    if (res.length == 0) {
      _streamController.add(null);
      return [];
    }
    res.forEach((e) {
      List handles = [];
      e.forEach((key, value) {
        var ks = key.split('_');
        if (ks.length > 1) {
          if (ks[1] == 'handle' && ks[0] != 'stopstalk' && value != '') {
            handles.add([ks[0], value]);
          }
        }
      });
      Friends prob = Friends(
          firstName: e["first_name"],
          lastName: e["last_name"],
          stopStalkHandle: e["stopstalk_handle"],
          handles: handles);
      searched.add(prob);
    });
    _streamController.add(searched);
  }

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
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search your friends",
                              icon: Icon(Icons.search)),
                        )),
                  ),
                  IconButton(
                      icon: Icon(!_filterActive
                          ? Icons.filter_list
                          : Icons.filter_none),
                      onPressed: () {
                        setState(() => {_filterActive = !_filterActive});
                      })
                ],
              ),
              !_filterActive
                  ? SizedBox()
                  : FutureBuilder(
                      future: myF,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) return SizedBox();
                        return Column(
                          children: [
                            DropdownButton<String>(
                              hint: Text("Select Institutes"),
                              value: selectedInstitute,
                              onChanged: (String value) {
                                setState(() {
                                  selectedInstitute = value;
                                });
                              },
                              items: snapshot.data[0]
                                  .map<DropdownMenuItem<String>>((String user) {
                                return DropdownMenuItem<String>(
                                  value: user,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.school,
                                        color: const Color(0xFF167F67),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Text(
                                          user,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            DropdownButton<String>(
                              hint: Text("Select Country"),
                              value: selectedCountry,
                              onChanged: (String value) {
                                setState(() {
                                  selectedCountry = value;
                                });
                              },
                              items: snapshot.data[1]
                                  .map<DropdownMenuItem<String>>((String user) {
                                return DropdownMenuItem<String>(
                                  value: user,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_city,
                                        color: const Color(0xFF167F67),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Text(
                                          user,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120.0,
                    child: RaisedButton(
                        elevation: 0,
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: Theme.of(context).buttonColor,
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
                        onPressed: () async {
                          _search();
                        }),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
                stream: _stream,
                builder: (ctx, snapshot) {
                  if (snapshot.data == "waiting") {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data == null) {
                    return Center(
                      child: Text("No result"),
                    );
                  }

                  if (snapshot.data == "init") {
                    return Center(
                      child: SizedBox(),
                    );
                  }

                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height,
                            child: AnimatedList(
                              key: _animatedListKey,
                              primary: true,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              initialItemCount: snapshot.data.length,
                              itemBuilder: (context, i, animation) {
                                return FriendCard(
                                    snapshot.data[i], context, i, animation);
                              },
                            )),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
