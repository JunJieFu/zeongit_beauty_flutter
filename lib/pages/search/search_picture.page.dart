import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/mixins/page_picture.mixin.dart';
import 'package:zeongitbeautyflutter/mixins/paging.mixin.dart';
import 'package:zeongitbeautyflutter/mixins/refresh.mixin.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/model/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search_picture_tune.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class SearchPicturePage extends StatefulWidget {
  SearchPicturePage({Key key, @required this.keyword}) : super(key: key);

  final String keyword;

  @override
  _SearchPicturePageState createState() => _SearchPicturePageState();
}

class _SearchPicturePageState extends State<SearchPicturePage>
    with
        AutomaticKeepAliveClientMixin,
        RefreshMixin,
        PagingMixin<SearchPicturePage, PictureEntity, PagePictureEntity>,
        PagePictureMixin {
  SearchTune _criteria = SearchTune();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _criteria.tagList = widget.keyword;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text(_criteria.tagList),
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(MdiIcons.tune),
//              onPressed: () {
//                Navigator.push(context, MaterialPageRoute(builder: (_) {
//                  return SearchTunePage(params: _criteria, callback: _query);
//                }));
//              },
//            ),
//            IconButton(
//              icon: Icon(Icons.search),
//              onPressed: () {
//                Navigator.push(context, MaterialPageRoute(builder: (_) {
//                  return SearchPage();
//                }));
//              },
//            )
//          ],
//        ),
        body: Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            _criteria.tagList,
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(MdiIcons.tune),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return SearchPictureTunePage(
                      params: _criteria, callback: _query);
                }));
              },
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 56),
          child: RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: refresh,
              child: emptyWidget()),
        )
      ],
    ));
  }

  @override
  TipsPageCardWidget buildEmptyType() {
    return TipsPageCardWidget(
        icon: Icons.search, title: "什么都搜不到哦", text: "您可以再换一些标签搜索哦。");
  }

  @override
  Future<ResultEntity<PagePictureEntity>> dao() =>
      PictureService.paging(pageable, criteria: _criteria);

  _query(SearchTune _) {
    _criteria = _;
    refresh();
  }
}
