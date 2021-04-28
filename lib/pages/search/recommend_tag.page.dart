import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/abstract/refresh.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/tag_frequency_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search.page.dart';
import 'package:zeongitbeautyflutter/pages/search/search_result.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';

class RecommendTagPage extends StatefulWidget {
  RecommendTagPage({Key key}) : super(key: key);

  @override
  RecommendTagPageState createState() => RecommendTagPageState();
}

class RecommendTagPageState extends RefreshAbstract<RecommendTagPage>
    with AutomaticKeepAliveClientMixin {
  List<TagFrequencyEntity> _recommendTagList;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        body: RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: _listTagTop30,
          child: ListView(
            controller: scrollController,
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
  bool get wantKeepAlive => true;

  Future<void> _listTagTop30() async {
    var result = await TagService.listTagTop30();
    setState(() {
      _recommendTagList = result.data;
    });
    return;
  }

  _search() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return SearchPage();
    }));
  }
}
