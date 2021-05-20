import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/collection_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_collection_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/mixins/paging_mixin.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class CollectionPage extends HookWidget {
  CollectionPage({Key? key, required this.id, this.controller})
      : logic = CollectionLogic(id, controller),
        super(key: key);

  final int id;

  final CustomRefreshController? controller;

  final CollectionLogic logic;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      logic.onStart();
      return logic.onDelete;
    }, const []);

    return KeepAliveClient(
      child: Scaffold(
          body: Obx(
        () => PageCollection(
          meta: logic.meta.value,
          list: logic.list,
          refreshController: logic.refreshController,
          refresh: logic.refresh,
          changePage: logic.changePage,
          emptyChild: TipsPageCard(
              icon: MdiIcons.star_outline,
              title: "没有作品",
              text: "您可以前往发现浏览一些系统推荐给您的作品哦。"),
        ),
      )),
    );
  }
}

class CollectionLogic extends GetxController
    with PagingMixin<CollectionEntity, PageCollectionEntity> {
  CollectionLogic(this.id, this.controller);

  final int id;

  final CustomRefreshController? controller;

  @override
  dao(pageable) => CollectionService.paging(pageable, id);

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
