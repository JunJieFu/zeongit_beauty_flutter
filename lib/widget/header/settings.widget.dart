import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        icon: Icon(Icons.settings),
        onSelected: (String value) {
          switch (value) {
            case "signOut":
//                  _signOut();
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem(
                value: "signOut",
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[Text("注销")],
                ),
              ),
            ]);
  }
}
