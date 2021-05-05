import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class FollowingNewPage extends HookWidget {
  FollowingNewPage({Key key, this.controller}) : super(key: key);

  final CustomRefreshController controller;

  @override
  Widget build(BuildContext context) {
    var pagingHookResult = usePaging<PictureEntity, PagePictureEntity>(
        context, (pageable) => PictureService.pagingByFollowing(pageable));

    var refreshController = pagingHookResult.refreshController;
    var list = pagingHookResult.list;
    var currPage = pagingHookResult.currPage;
    var refresh = pagingHookResult.refresh;
    var changePage = pagingHookResult.changePage;

    controller?.refresh = () {
      refreshController.value
          .requestRefresh(duration: const Duration(milliseconds: 200));
    };

    return KeepAliveClient(
      child: Scaffold(
          body: PagePicture(
        currPage: currPage.value,
        list: list.value,
        refreshController: refreshController.value,
        refresh: refresh,
        changePage: changePage,
        emptyChild: TipsPageCard(
            icon: MdiIcons.account_multiple_outline,
            title: "没有作品",
            text: "您可以前往发现浏览一些系统推荐给您的作品哦。"),
      )),
    );
  }
}
