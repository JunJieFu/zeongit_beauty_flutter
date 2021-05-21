import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/mixins/paging_mixin.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class FollowingNewPage extends HookWidget {
  FollowingNewPage({Key? key, this.controller}) : super(key: key);

  final CustomRefreshController? controller;

  @override
  Widget build(BuildContext context) {
    final pagingHookResult = usePaging<PictureEntity, PagePictureEntity>(
        context, (pageable) => PictureService.pagingByFollowing(pageable));

    final refreshController = pagingHookResult.refreshController;
    final list = pagingHookResult.list;
    final meta = pagingHookResult.meta;
    final refresh = pagingHookResult.refresh;
    final changePage = pagingHookResult.changePage;

    useEffect(() {
      controller?.refresh = () {
        refreshController.requestRefresh();
      };
      return () {
        controller?.dispose();
      };
    }, const []);

    return KeepAliveClient(
      child: Scaffold(
          body: Obx(
        () => PagePicture(
          meta: meta.value,
          list: list,
          refreshController: refreshController,
          refresh: refresh,
          changePage: changePage,
          emptyChild: TipsPageCard(
              icon: MdiIcons.compass,
              title: "没有作品",
              text: "您可以前往发现浏览一些系统推荐给您的作品哦。"),
        ),
      )),
    );
  }
}
