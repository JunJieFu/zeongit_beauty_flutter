import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/widget/picture_list_waterfall.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

abstract class PagePictureAbstract<T extends StatefulWidget> extends State<T> {
  bool loading = false;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  GlobalKey<PictureListWaterfallWidgetState> listWidgetKey =
      GlobalKey<PictureListWaterfallWidgetState>();
  PagePictureEntity currPage;
  List<PictureEntity> list = [];
  PageableEntity pageable = PageableEntity();

  Future<void> refresh() async {
    paging(1);
  }

  Future<void> paging(int pageIndex) async {
    pageable.page = pageIndex;
    if (this.loading ||
        (currPage?.meta != null && currPage.meta.last && pageIndex != 1))
      return;
    loading = true;
    var result = await dao();
    setState(() {
      currPage = result.data;
      if (currPage.meta.first) {
        listWidgetKey?.currentState?.goTo();
        list = currPage.items;
      } else {
        list.addAll(currPage.items);
      }
    });
    loading = false;
  }

  Widget emptyWidget() {
    if (currPage?.meta != null &&
        currPage.meta.empty &&
        currPage.meta.first &&
        currPage.meta.last) {
      return ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [buildEmptyType()]);
    } else {
      return buildListWaterFall();
    }
  }

  parentTabTap() {
    listWidgetKey.currentState?.scrollController?.animateTo(0,
        duration: Duration(milliseconds: StyleConfig.durationMilliseconds),
        curve: Curves.ease);
    refreshIndicatorKey.currentState?.show();
  }

  PictureListWaterfallWidget buildListWaterFall() {
    return PictureListWaterfallWidget(
        key: listWidgetKey,
        currPage: currPage,
        list: list,
        paging: paging);
  }

  TipsPageCardWidget buildEmptyType();

  Future<ResultEntity<PagePictureEntity>> dao();
}
