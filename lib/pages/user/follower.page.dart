import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/mixins/page_user.mixin.dart';
import 'package:zeongitbeautyflutter/mixins/paging.mixin.dart';
import 'package:zeongitbeautyflutter/mixins/refresh.mixin.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class FollowerPage extends StatefulWidget {
  FollowerPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage>
    with
        AutomaticKeepAliveClientMixin,
        RefreshMixin,
        PagingMixin<FollowerPage, UserInfoEntity, PageUserInfoEntity>,
        PageUserMixin {
  @override
  bool get wantKeepAlive => true;

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
        body: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: refresh,
            child: emptyWidget()));
  }

  @override
  TipsPageCardWidget buildEmptyType() =>
      TipsPageCardWidget(icon: MdiIcons.account_heart_outline, title: "没有粉丝");

  @override
  Future<ResultEntity<PageUserInfoEntity>> dao() =>
      FollowerService.pagingFollower(pageable, widget.id);
}
