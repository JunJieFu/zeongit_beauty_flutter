import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/mixins/paging_mixin.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class NewPage extends HookWidget {
  NewPage({Key? key, this.controller})
      : logic = NewLogic(controller),
        super(key: key);

  final CustomRefreshController? controller;

  final NewLogic logic;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      logic.onStart();
      return logic.onDelete;
    }, const []);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("最新"),
          actions: [
            IconButton(
              icon: Icon(MdiIcons.calendar_month_outline),
              onPressed: logic.showStartDatePicker,
            ),
            IconButton(
              icon: Icon(MdiIcons.refresh),
              onPressed: () {
                logic.dateRefresh(force: true);
              },
            )
          ],
        ),
        body: Obx(
          () => PagePicture(
            meta: logic.meta.value,
            list: logic.list,
            refreshController: logic.refreshController,
            refresh: logic.refresh,
            changePage: logic.changePage,
            emptyChild: TipsPageCard(
                icon: MdiIcons.compass, title: "没有作品", text: "难道是系统出现什么问题了。"),
          ),
        ));
  }
}

class NewLogic extends GetxController
    with PagingMixin<PictureEntity, PagePictureEntity> {
  NewLogic(this.controller);

  final CustomRefreshController? controller;

  final criteria = SearchPictureTune().obs;

  @override
  dao(pageable) => PictureService.paging(pageable, criteria: criteria.value);

  dateRefresh({DateTime? dateTime, bool force = false}) {
    criteria.value.date.startDate = dateTime;
    criteria.value.date.endDate = dateTime;
    if (dateTime != null || force) {
      refreshController.requestRefresh(needMove: false);
    }
  }

  showStartDatePicker() async {
    var dateTime = await showDatePicker(
        context: Get.context!,
        initialDate: criteria.value.date.startDate ?? DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime.now());
    dateRefresh(dateTime: dateTime);
  }

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
