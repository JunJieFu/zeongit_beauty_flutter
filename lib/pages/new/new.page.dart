import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class NewPage extends HookWidget {
  NewPage({Key? key, this.controller}) : super(key: key);

  final CustomRefreshController? controller;

  final _criteria = SearchPictureTune().obs;

  @override
  Widget build(BuildContext context) {
    final pagingHookResult = usePaging<PictureEntity, PagePictureEntity>(
        context,
        (pageable) =>
            PictureService.paging(pageable, criteria: _criteria.value));

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

    dateRefresh({DateTime? dateTime, bool force = false}) {
      _criteria.value.date.startDate = dateTime;
      _criteria.value.date.endDate = dateTime;
      if (dateTime != null || force) {
        refreshController.requestRefresh(needMove: false);
      }
    }

    showStartDatePicker() async {
      var dateTime = await showDatePicker(
          context: Get.context!,
          initialDate: _criteria.value.date.startDate ?? DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime.now());
      dateRefresh(dateTime: dateTime);
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("最新"),
          actions: [
            IconButton(
              icon: Icon(MdiIcons.calendar_month_outline),
              onPressed: showStartDatePicker,
            ),
            IconButton(
              icon: Icon(MdiIcons.refresh),
              onPressed: () {
                dateRefresh(force: true);
              },
            )
          ],
        ),
        body: Obx(
          () => PagePicture(
            meta: meta.value,
            list: list,
            refreshController: refreshController,
            refresh: refresh,
            changePage: changePage,
            emptyChild: TipsPageCard(
                icon: MdiIcons.compass, title: "没有作品", text: "难道是系统出现什么问题了。"),
          ),
        ));
  }
}
