import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/footprint_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_footprint_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/mixins/paging_mixin.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class FootprintPage extends HookWidget {
  FootprintPage({Key? key, required this.id, this.controller})
      : logic = FootprintLogic(id, controller),
        super(key: key);

  final int id;

  final CustomRefreshController? controller;

  final FootprintLogic logic;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      logic.onStart();
      return logic.onDelete;
    }, const []);

    return Scaffold(
        appBar: AppBar(title: Text("足迹")),
        body: Obx(() => PageFootprint(
              meta: logic.meta.value,
              list: logic.list,
              refreshController: logic.refreshController,
              refresh: logic.refresh,
              changePage: logic.changePage,
              emptyChild: TipsPageCard(
                  icon: MdiIcons.shoe_print,
                  title: "没有作品",
                  text: "您可以前往发现浏览一些系统推荐给您的作品哦。"),
            )));
  }
}

class FootprintLogic extends GetxController
    with PagingMixin<FootprintEntity, PageFootprintEntity> {
  FootprintLogic(this.id, this.controller);

  final int id;

  final CustomRefreshController? controller;

  @override
  dao(pageable) => FootprintService.paging(pageable, id);

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
