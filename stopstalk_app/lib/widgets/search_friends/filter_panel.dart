import 'package:flutter/material.dart';

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class FilterPanel extends StatefulWidget {
  @override
  _FilterPanelState createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  Item selectedUser;
  List<Item> users = <Item>[
    const Item(
        'Android jhviul jk obububuhihhiopmpopn oinibinbion  ',
        Icon(
          Icons.school,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Flutter',
        Icon(
          Icons.flag,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'ReactNative',
        Icon(
          Icons.format_indent_decrease,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'iOS',
        Icon(
          Icons.mobile_screen_share,
          color: const Color(0xFF167F67),
        )),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<Item>(
          hint: Text("Select item"),
          value: selectedUser,
          onChanged: (Item value) {
            setState(() {
              selectedUser = value;
            });
          },
          items: users.map((Item user) {
            return DropdownMenuItem<Item>(
              value: user,
              child: Row(
                children: <Widget>[
                  user.icon,
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      user.name,
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
        DropdownButton<Item>(
          hint: Text("Select item"),
          value: selectedUser,
          onChanged: (Item value) {
            setState(() {
              selectedUser = value;
            });
          },
          items: users.map((Item user) {
            return DropdownMenuItem<Item>(
              value: user,
              child: Row(
                children: <Widget>[
                  user.icon,
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      user.name,
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
  }
}
