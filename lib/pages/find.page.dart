import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/list_waterfall.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class FindPage extends StatefulWidget {
  FindPage({Key key}) : super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  PagePictureEntity page;
  List<PictureEntity> list = [];
  PageableEntity pageable = PageableEntity();

  Future<void> refresh() async {
    paging(0);
  }

  Future<void> paging(int pageIndex) async {
    pageable.page = pageIndex;
    if (this.loading || (this.page != null && this.page.last && pageIndex != 0)) return;
    loading = true;
    var result = await PictureService.pagingByRecommend(pageable);
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
        key: refreshIndicatorKey,
        onRefresh: refresh,
        child: emptyWidget());
  }

  Widget emptyWidget() {
    if (page != null && page.empty && page.first && page.last) {
      return TipsPageCardWidget(
          icon: MdiIcons.compass,
          title: "没有作品",
          text: "难道是系统出现什么问题了。");
    } else {
      return ListWaterFallWidget(page: page, list: list, paging: paging);
    }
  }
}
