import 'package:flutter/material.dart';
import 'file:///D:/project/flutter/zeongit_beauty_flutter/lib/pages/search/search.page.dart';

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
//      UserWidget(),
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
