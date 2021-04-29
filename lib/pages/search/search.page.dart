import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/pages/search/search_tab.page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _keywordController = TextEditingController();

  _search() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return SearchTabPage(keyword: _keywordController.text);
    }));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      elevation: 1,
      title: TextField(
          autofocus: true,
          controller: _keywordController,
          decoration: InputDecoration(
            hintText: "搜索网站绘画",
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

  @override
  void dispose() {
    super.dispose();
    _keywordController.dispose();
  }
}
