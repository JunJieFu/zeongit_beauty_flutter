import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/list_waterfall.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

import '../assets/service/index.dart';

class FollowingNewPage extends StatefulWidget {
  FollowingNewPage({Key key}) : super(key: key);

  @override
  _FollowingNewPageState createState() => _FollowingNewPageState();
}

class _FollowingNewPageState extends State<FollowingNewPage> {
  bool loading = false;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
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
    var result = await PictureService.pagingByFollowing(pageable);
    setState(() {
      currPage = result.data;
      list.addAll(currPage.items);
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
        appBar: AppBar(title: Text("关注最新")),
        body: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: refresh,
            child: emptyWidget()));
  }

  Widget emptyWidget() {
    if (currPage?.meta != null &&
        currPage.meta.empty &&
        currPage.meta.first &&
        currPage.meta.last) {
      return TipsPageCardWidget(
          icon: MdiIcons.account_multiple_outline,
          title: "没有作品",
          text: "您可以前往发现浏览一些系统推荐给您的作品哦。");
    } else {
      return ListWaterFallWidget(
          currPage: currPage, list: list, paging: paging);
    }
  }
}
