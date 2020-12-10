import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopstalkapp/widgets/search_friends/filter_panel.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _filterActive = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.87,
              child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search your friends",
                        icon: Icon(Icons.search)),
                  )),
            ),
            IconButton(
                icon: Icon(
                    !_filterActive ? Icons.filter_list : Icons.filter_none),
                onPressed: () {
                  setState(() => {_filterActive = !_filterActive});
                })
          ],
        ),
        !_filterActive ? SizedBox() : FilterPanel(),
        MaterialButton(
          onPressed: null,
          child: Container(
            color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Search",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "WorkSansBold"),
              ),
            ),
          ),
        )
      ],
    );
  }
}
