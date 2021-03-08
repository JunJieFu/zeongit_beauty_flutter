import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/abstract/page_picture.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search.page.dart';
import 'package:zeongitbeautyflutter/pages/search/search_tune.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({Key key, @required this.keyword}) : super(key: key);

  final String keyword;

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends PagePictureAbstract<SearchResultPage> {
  SearchTuneParams tune = SearchTuneParams();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.keyword),
          actions: <Widget>[
            IconButton(
              icon: Icon(MdiIcons.tune),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return SearchTunePage(
                      params: tune,
                      callback: (SearchTuneParams _) {
                        tune = _;
                        paging(1);
                      });
                }));
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
        ),
        body: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: refresh,
            child: emptyWidget()));
  }

  @override
  TipsPageCardWidget buildEmptyType() {
    return TipsPageCardWidget(
        icon: Icons.search, title: "什么都搜不到哦", text: "您可以再换一些标签搜索哦。");
  }

  @override
  Future<ResultEntity<PagePictureEntity>> dao() => PictureService.paging(
        pageable,
        tagList: widget.keyword,
        name: tune.name,
        precise: tune.precise,
        startDate: tune.date.startDate,
        endDate: tune.date.endDate,
        startWidth: tune.startWidth,
        endWidth: tune.endWidth,
        startHeight: tune.startHeight,
        endHeight: tune.endHeight,
        startRatio: tune.startRatio,
        endRatio: tune.endRatio,
      );
}
