import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/abstract/page_user.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class FollowingPage extends StatefulWidget {
  FollowingPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends PageUserAbstract<FollowingPage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("关注")),
        body: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: refresh,
            child: emptyWidget()));
  }

  @override
  TipsPageCardWidget buildEmptyType() =>
      TipsPageCardWidget(icon: MdiIcons.account_star_outline, title: "没有关注");

  @override
  Future<ResultEntity<PageUserInfoEntity>> dao() =>
      FollowingService.pagingFollowing(pageable, widget.id);
}
