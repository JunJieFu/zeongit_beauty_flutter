import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/widget/list_tag.widget.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class BlackHoleTagPage extends StatefulWidget {
  @override
  _BlackHoleTagPageState createState() => _BlackHoleTagPageState();
}

class _BlackHoleTagPageState extends State<BlackHoleTagPage>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  PageTagBlackHoleEntity currPage;
  List<TagBlackHoleEntity> list = [];
  PageableEntity pageable = PageableEntity();

  Future<void> refresh() async {
    paging(1);
  }

  Future<void> paging(int pageIndex) async {
    pageable.page = pageIndex;
    bool last = this.currPage?.meta != null &&
        this.currPage.meta.totalPages <= currPage.meta.currentPage;
    if (this.loading || (last && currPage.meta.currentPage <= pageIndex))
      return;
    loading = true;
    var result = await TagBlackHoleService.paging(pageable);
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
    super.build(context);
    return RefreshIndicator(
        key: refreshIndicatorKey, onRefresh: refresh, child: emptyWidget());
  }

  @override
  bool get wantKeepAlive => true;

  Widget emptyWidget() {
    bool last = this.currPage?.meta != null &&
        this.currPage.meta.totalPages <= currPage.meta.currentPage;
    if (currPage != null &&
        currPage.items.isEmpty &&
        currPage.meta.currentPage == 1 &&
        last) {
      return TipsPageCardWidget(
          icon: MdiIcons.account_heart_outline, title: "没有粉丝");
    } else {
      return ListTagWidget(currPage: currPage, list: list, paging: paging);
    }
  }
}
