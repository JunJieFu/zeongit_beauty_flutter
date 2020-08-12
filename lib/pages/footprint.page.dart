import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/list_waterfall.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class FootprintPage extends StatefulWidget {
  @override
  _FootprintPageState createState() => _FootprintPageState();
}

class _FootprintPageState extends State<FootprintPage> {
  bool loading = false;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  PagePictureEntity page;
  List<PictureEntity> list = [];
  PageableEntity pageable = PageableEntity();

  Future<void> refresh() async {
    paging(0);
  }

  Future<void> paging(int pageIndex) async {
    pageable.page = pageIndex;
    if (this.loading || (this.page != null && this.page.last)) return;
    loading = true;
    var result = await FootprintService.paging(pageable);
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
        appBar: AppBar(title: Text("足迹")),
        body: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: refresh,
            child: emptyWidget()));
  }

  Widget emptyWidget() {
    if (page != null && page.empty && page.first && page.last) {
      return TipsPageCardWidget(
          icon: MdiIcons.star_outline,
          title: "没有作品",
          text: "您可以前往发现浏览一些系统推荐给您的作品哦。",
          btnDesc: "前往发现");
    } else {
      return ListWaterFallWidget(page: page, list: list, paging: paging);
    }
  }
}
