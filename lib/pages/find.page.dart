import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/list_waterfall.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

import '../plugins/style/index.style.dart';

class FindPage extends StatefulWidget {
  FindPage({Key key}) : super(key: key);

  @override
  FindPageState createState() => FindPageState();
}

class FindPageState extends State<FindPage>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  GlobalKey<ListWaterFallWidgetState> pictureListWaterFallWidgetKey =
      GlobalKey<ListWaterFallWidgetState>();
  PagePictureEntity currPage;
  List<PictureEntity> list = [];
  PageableEntity pageable = PageableEntity();

  Future<void> refresh() async {
    paging(1);
  }

  Future<void> paging(int pageIndex) async {
    pageable.page = pageIndex;
    if (this.loading || (currPage?.meta != null && currPage.meta.last)) return;
    loading = true;
    var result = await PictureService.pagingByRecommend(pageable);
    setState(() {
      currPage = result.data;
      list.addAll(currPage.items);
    });
    loading = false;
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        key: refreshIndicatorKey, onRefresh: refresh, child: emptyWidget());
  }

  Widget emptyWidget() {
    if (currPage?.meta != null &&
        currPage.meta.empty &&
        currPage.meta.first &&
        currPage.meta.last) {
      return TipsPageCardWidget(
          icon: MdiIcons.compass, title: "没有作品", text: "难道是系统出现什么问题了。");
    } else {
      return ListWaterFallWidget(
          key: pictureListWaterFallWidgetKey,
          currPage: currPage,
          list: list,
          paging: paging);
    }
  }

  parentTabTap() {
    pictureListWaterFallWidgetKey.currentState?.scrollController?.animateTo(0,
        duration: Duration(milliseconds: StyleConfig.durationMilliseconds),
        curve: Curves.ease);
    refreshIndicatorKey.currentState?.show();
  }
}
