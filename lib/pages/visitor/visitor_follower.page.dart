import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor.provider.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/list_user.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class VisitorFollowerPage extends StatefulWidget {
  @override
  _VisitorFollowerPageState createState() => _VisitorFollowerPageState();
}

class _VisitorFollowerPageState extends State<VisitorFollowerPage>
    with AutomaticKeepAliveClientMixin {
  bool loading = false;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  PageUserInfoEntity currPage;
  List<UserInfoEntity> list = [];
  PageableEntity pageable = PageableEntity();
  int targetId;

  Future<void> refresh() async {
    paging(1);
  }

  Future<void> paging(int pageIndex) async {
    pageable.page = pageIndex;
    if (this.loading || (currPage?.meta != null  && currPage.meta.last)) return;
    loading = true;
    var result =
        await FollowerService.pagingFollower(pageable, targetId);
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
    return Consumer<VisitorState>(
        builder: (ctx, VisitorState visitorState, child) {
      targetId = visitorState.info.id;
      return RefreshIndicator(
          key: refreshIndicatorKey,
          onRefresh: refresh,
          child: _emptyWidget());
    });
  }

  Widget _emptyWidget() {
    bool last = this.currPage?.meta != null &&
        this.currPage.meta.totalPages <= currPage.meta.currentPage;
    if (currPage != null &&
        currPage.items.isEmpty &&
        currPage.meta.currentPage == 1 &&
        last) {
      return TipsPageCardWidget(
          icon: MdiIcons.account_heart_outline,
          title: "没有粉丝");
    } else {
      return ListUserWidget(currPage: currPage, list: list, paging: paging);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
