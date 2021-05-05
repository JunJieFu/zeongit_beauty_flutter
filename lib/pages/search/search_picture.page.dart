import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/mixins/paging.mixin.dart';
import 'package:zeongitbeautyflutter/pages/search/search_picture_tune.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
          child: SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: currPage != null && !currPage.meta.last,
            onRefresh: refresh,
            onLoading: () async {
              await changePage(currPage.meta.currentPage + 1);
            },
            child: emptyWidget(),
          ),
        )
      ],
    ));
  }

  @override
  Future<ResultEntity<PagePictureEntity>> dao() =>
      PictureService.paging(pageable, criteria: _criteria);

  @override
  TipsPageCard buildEmptyType() {
    return TipsPageCard(
        icon: Icons.search, title: "什么都搜不到哦", text: "您可以再换一些标签搜索哦。");
  }

  _query(SearchTune _) {
    _criteria = _;
    refreshController.requestRefresh(needMove: false);
  }
}
