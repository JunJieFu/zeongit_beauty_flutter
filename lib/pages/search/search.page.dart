import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search_result.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/provider/tag.provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TagState tagState;
  bool loading = true;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  TextEditingController keywordController = TextEditingController();

  Future<void> _listTagTop30() async {
    var result = await TagService.listTagTop30();
    tagState.setRecommendTagList(result.data);
    setState(() {
      loading = false;
    });
    return;
  }

  _search() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return SearchResultPage(keyword: keywordController.text);
    }));
  }

  @override
  void initState() {
    super.initState();
    refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (tagState.recommendTagList == null) {
        refreshIndicatorKey.currentState?.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    tagState = Provider.of<TagState>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: TextField(
              autofocus: true,
              controller: keywordController,
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
        ),
        body: RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: _listTagTop30,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(StyleConfig.gap * 2),
                child: Wrap(
                    spacing: StyleConfig.gap * 2,
                    runSpacing: -StyleConfig.gap,
                    children: tagState.recommendTagList
                            ?.map((e) => ActionChip(
                                label: Text(e.name),
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (_) {
                                    return SearchResultPage(keyword: e.name);
                                  }));
                                }))
                            ?.toList() ??
                        <Widget>[]),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    keywordController.dispose();
  }
}
