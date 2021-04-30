import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/mixins/refresh2.dart';
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
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: currPage != null && !currPage.meta.last,
      onRefresh: refresh,
      onLoading: () async {
        await changePage(currPage.meta.currentPage + 1);
      },
      child: emptyWidget(),
    ));
  }

  @override
  Future<ResultEntity<PageUserInfoEntity>> dao() =>
      FollowerService.pagingFollower(pageable, widget.id);

  @override
  TipsPageCardWidget buildEmptyType() =>
      TipsPageCardWidget(icon: MdiIcons.account_heart_outline, title: "没有粉丝");
}
