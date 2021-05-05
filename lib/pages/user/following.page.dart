import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/mixins/paging.mixin.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class FollowingPage extends StatefulWidget {
  FollowingPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  FollowingPageState createState() => FollowingPageState();
}

class FollowingPageState extends State<FollowingPage>
    with
        AutomaticKeepAliveClientMixin,
        RefreshMixin,
        PagingMixin<FollowingPage, UserInfoEntity, PageUserInfoEntity>,
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
  TipsPageCard buildEmptyType() =>
      TipsPageCard(icon: MdiIcons.account_star_outline, title: "没有关注");

  @override
  Future<ResultEntity<PageUserInfoEntity>> dao() =>
      FollowingService.pagingFollowing(pageable, widget.id);
}
