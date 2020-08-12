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
  PageUserInfoEntity page;
  List<UserInfoEntity> list = [];
  PageableEntity pageable = PageableEntity();
  int targetId;

  Future<void> refresh() async {
    paging(0);
  }

  Future<void> paging(int pageIndex) async {
    pageable.page = pageIndex;
    if (this.loading || (this.page != null && this.page.last)) return;
    loading = true;
    var result =
        await UserService.pagingFollower(pageable, targetId: targetId);
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
    if (page != null && page.empty && page.first && page.last) {
      return TipsPageCardWidget(
          icon: MdiIcons.account_heart_outline,
          title: "没有粉丝");
    } else {
      return ListUserWidget(page: page, list: list, paging: paging);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
