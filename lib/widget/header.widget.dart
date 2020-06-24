import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/pages/search.page.dart';
import 'package:zeongitbeautyflutter/widget/header/user.widget.dart';

import 'header/settings.widget.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      title: Text("主页"),
      actions: <Widget>[
        UserWidget(),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {

          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return SearchPage();
            }));
          },
        )
      ],
    );
  }
}
