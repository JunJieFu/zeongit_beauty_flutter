import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/widget/menu.widget.dart';
import 'package:zeongitbeautyflutter/widget/header.widget.dart';

class HomePage extends StatelessWidget {
  _signOut() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderWidget(),
        drawer: Drawer(
          //New added
          child: MenuWidget(), //New added
        ), //New added
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center),
        ));
  }
}
