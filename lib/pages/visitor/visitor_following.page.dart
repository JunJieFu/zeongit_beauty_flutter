import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/abstract/page_user.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor.provider.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class VisitorFollowingPage extends StatefulWidget {
  @override
  _VisitorFollowingPageState createState() => _VisitorFollowingPageState();
}

class _VisitorFollowingPageState extends PageUserAbstract<VisitorFollowingPage>
    with AutomaticKeepAliveClientMixin {
  int _targetId;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<VisitorState>(
        builder: (ctx, VisitorState visitorState, child) {
      _targetId = visitorState.info.id;
      return RefreshIndicator(
          key: refreshIndicatorKey, onRefresh: refresh, child: emptyWidget());
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  TipsPageCardWidget buildEmptyType() =>
      TipsPageCardWidget(icon: MdiIcons.account_star_outline, title: "没有关注");

  @override
  Future<ResultEntity<PageUserInfoEntity>> dao() =>
      FollowingService.pagingFollowing(pageable, _targetId);
}
