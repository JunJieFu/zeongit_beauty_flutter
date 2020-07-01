import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/pages/search_result.page.dart';
import 'package:zeongitbeautyflutter/provider/tag.provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TagState _tagState;
  bool _loading = true;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;
  TextEditingController _keywordController = TextEditingController();

  Future<void> _listTagTop30() async {
    var result = await TagService.listTagTop30();
    setState(() {
      _tagState.setRecommendTagList(result.data);
      _loading = false;
    });
    return;
  }

  @override
  void initState() {
    super.initState();
    _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_tagState.recommendTagList == null) {
        _refreshIndicatorKey.currentState?.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _tagState = Provider.of<TagState>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: TextField(
            autofocus: true,
            controller: _keywordController,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) {
                  return SearchResultPage(keyword: _keywordController.text);
                }));
              },
            )
          ],
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _listTagTop30,
          color: Colors.grey,
          backgroundColor: Colors.white,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(StyleConfig.gap * 2),
                child: Wrap(
                    spacing: StyleConfig.gap * 2,
                    runSpacing: -StyleConfig.gap,
                    children: _tagState.recommendTagList
                            ?.map((e) => ActionChip(
                                label: Text(e),
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (_) {
                                    return SearchResultPage(keyword: e);
                                  }));
                                }))
                            ?.toList() ??
                        <Widget>[]),
              )
            ],
          ),
        ));
  }
}
