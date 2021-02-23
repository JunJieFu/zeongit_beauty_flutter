import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/pages/search/search.page.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  HeaderWidget({Key key, this.title}) : super(key: key);

  final Widget title;

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(title: title, actions: <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return SearchPage();
          }));
        },
      ),
    ]);
  }
}
