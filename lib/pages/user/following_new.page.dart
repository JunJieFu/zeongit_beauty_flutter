import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/mixins/paging_mixin.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class FollowingNewPage extends HookWidget {
  FollowingNewPage({Key? key, this.controller})
      : logic = FollowingNewLogic(controller),
        super(key: key);

  final CustomRefreshController? controller;

  final FollowingNewLogic logic;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      logic.onStart();
      return logic.onDelete;
    }, const []);

    return KeepAliveClient(
      child: Scaffold(
          body: Obx(
        () => PagePicture(
          meta: logic.meta.value,
          list: logic.list,
          refreshController: logic.refreshController,
          refresh: logic.refresh,
          changePage: logic.changePage,
          emptyChild: TipsPageCard(
              icon: MdiIcons.compass,
              title: "没有作品",
              text: "您可以前往发现浏览一些系统推荐给您的作品哦。"),
        ),
      )),
    );
  }
}

class FollowingNewLogic extends GetxController
    with PagingMixin<PictureEntity, PagePictureEntity> {
  FollowingNewLogic(this.controller);

  final CustomRefreshController? controller;

  @override
  dao(pageable) => PictureService.pagingByFollowing(pageable);

  @override
  void onInit() {
    super.onInit();
    controller?.refresh = () {
      refreshController.requestRefresh(
          duration: const Duration(milliseconds: 200));
    };
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }
}
