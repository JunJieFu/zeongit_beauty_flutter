import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search.page.dart';
import 'package:zeongitbeautyflutter/pages/search/search_tune.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/list_waterfall.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({Key key, @required this.keyword}) : super(key: key);

  final String keyword;

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  bool loading = false;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  PagePictureEntity page;
  List<PictureEntity> list = [];
  PageableEntity pageable =
      PageableEntity(page: 0, size: 16, sort: "createDate,desc");
  SearchTuneParams tune = SearchTuneParams();

  Future<void> _refresh() async {
    paging(0);
  }

  Future<void> paging(int pageIndex) async {
    pageable.page = pageIndex;
    if (this.loading || (this.page != null && this.page.last && pageIndex != 0))
      return;
    loading = true;
    var result = await PictureService.paging(pageable,
        tagList: widget.keyword,
        name: tune.name,
        precise: tune.precise,
        startDate: tune.date.startDate,
        endDate: tune.date.endDate);
    setState(() {
      page = result.data;
      if (pageIndex == 0) {
        list = page.content;
      } else {
        list.addAll(page.content);
      }
    });
    loading = false;
  }

  @override
  void initState() {
    super.initState();
    refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

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
                        paging(0);
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
            onRefresh: _refresh,
            child: _emptyWidget()));
  }

  Widget _emptyWidget() {
    if (page != null && page.empty && page.first && page.last) {
      return TipsPageCardWidget(
          icon: Icons.search, title: "什么都搜不到哦", text: "您可以再换一些标签搜索哦。");
    } else {
      return ListWaterFallWidget(page: page, list: list, paging: paging);
    }
  }
}
