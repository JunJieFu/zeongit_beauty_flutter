import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/pages/search/search_tab.page.dart';

class SearchPage extends HookWidget {
  SearchPage({Key key, this.keyword, this.index}) : super(key: key);
  final String keyword;
  final int index;

  @override
  Widget build(BuildContext context) {
    var keywordController = useTextEditingController();
    keywordController.text = keyword;
    _search() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return SearchTabPage(
          keyword: keywordController.text,
          index: index,
        );
      }));
    }

    return Scaffold(
        appBar: AppBar(
      elevation: 1,
      title: TextField(
          autofocus: true,
          controller: keywordController,
          decoration: InputDecoration(
            hintText: "搜索",
            border: InputBorder.none,
          ),
          onSubmitted: (text) {
            _search();
          }),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            _search();
          },
        )
      ],
    ));
  }
}
