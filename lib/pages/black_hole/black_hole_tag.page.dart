import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/widget/list_tag.widget.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';
import 'package:zeongitbeautyflutter/abstract/paging.abstract.dart';

class BlackHoleTagPage extends StatefulWidget {
  @override
  _BlackHoleTagPageState createState() => _BlackHoleTagPageState();
}

class _BlackHoleTagPageState extends PagingAbstract<
    BlackHoleTagPage,
    TagBlackHoleEntity,
    PageTagBlackHoleEntity> with AutomaticKeepAliveClientMixin {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        key: _refreshIndicatorKey, onRefresh: refresh, child: emptyWidget());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<ResultEntity<PageTagBlackHoleEntity>> dao() =>
      TagBlackHoleService.paging(pageable);

  Widget emptyWidget() {
    if (currPage != null &&
        currPage.items.isEmpty &&
        currPage.meta.currentPage == 1 &&
        currPage.meta.last) {
      return TipsPageCardWidget(icon: MdiIcons.tag_outline, title: "没有屏蔽标签");
    } else {
      return ListTagWidget(
          currPage: currPage,
          list: list,
          controller: scrollController,
          changePage: changePage);
    }
  }
}
