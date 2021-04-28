import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/abstract/paging.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/widget/list_user.widget.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class BlackHoleUserPage extends StatefulWidget {
  @override
  _BlackHoleUserPageState createState() => _BlackHoleUserPageState();
}

class _BlackHoleUserPageState extends PagingAbstract<
    BlackHoleUserPage,
    UserBlackHoleEntity,
    PageUserBlackHoleEntity> with AutomaticKeepAliveClientMixin {
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

  @override
  Future<ResultEntity<PageUserBlackHoleEntity>> dao() =>
      UserBlackHoleService.paging(pageable);

  Widget emptyWidget() {
    if (currPage?.meta != null &&
        currPage.meta.empty &&
        currPage.meta.first &&
        currPage.meta.last) {
      return TipsPageCardWidget(
          icon: MdiIcons.account_outline, title: "没有屏蔽用户");
    } else {
      return ListUserWidget(
          currPage: currPage,
          list: list,
          controller: scrollController,
          changePage: changePage);
    }
  }
}
