import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
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

  Future<void> listTagTop30() async {
    if (_tagState.recommendTagList == null) {
      var result = await TagService.listTagTop30();
      setState(() {
        _tagState.setRecommendTagList(result.data);
      });
    }
    setState(() {
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
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: listTagTop30,
          color: Colors.grey,
          backgroundColor: Colors.white,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: Wrap(
                    spacing: 8,
                    runSpacing: -4,
                    children: _tagState.recommendTagList
                            ?.map((e) => ActionChip(
                                label: Text(e),
                                onPressed: () {
                                  print(e);
                                }))
                            ?.toList() ??
                        <Widget>[]),
              )
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
