import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/tag_frequency_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/mixins/paging.mixin.dart';
import 'package:zeongitbeautyflutter/pages/search/search.page.dart';
import 'package:zeongitbeautyflutter/pages/search/search_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';

class RecommendTagPage extends StatefulWidget {
  RecommendTagPage({Key key}) : super(key: key);

  @override
  RecommendTagPageState createState() => RecommendTagPageState();
}

class RecommendTagPageState extends State<RecommendTagPage>
    with AutomaticKeepAliveClientMixin, RefreshMixin {
  List<TagFrequencyEntity> _recommendTagList;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var a = useRefresh(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                _search();
              },
            )
          ],
        ),
        body: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: _listTagTop30,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(StyleConfig.gap * 2),
                child: Wrap(
                    spacing: StyleConfig.gap * 2,
                    runSpacing: -StyleConfig.gap,
                    children: _recommendTagList
                            ?.map((e) => ActionChip(
                                label: Text(e.name),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return SearchTabPage(keyword: e.name);
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
  bool get wantKeepAlive => true;

  Future<void> _listTagTop30() async {
    var result = await TagService.listTagTop30();
    setState(() {
      _recommendTagList = result.data;
    });
    refreshController.refreshCompleted();
    return;
  }

  _search() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return SearchPage();
    }));
  }
}

class RecommendTagPage2 extends HookWidget {
  RecommendTagPage2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var result = useRefresh(context);

    return Scaffold(
      body: SmartRefresher(
        controller: result.refreshController,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: result.listTagTop30,
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(StyleConfig.gap * 2),
              child: Wrap(
                  spacing: StyleConfig.gap * 2,
                  runSpacing: -StyleConfig.gap,
                  children: result.recommendTagList
                          ?.map((e) => ActionChip(
                              label: Text(e.name),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return SearchTabPage(keyword: e.name);
                                }));
                              }))
                          ?.toList() ??
                      <Widget>[]),
            )
          ],
        ),
      ),
    );
  }
}
