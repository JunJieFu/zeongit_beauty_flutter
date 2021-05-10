import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/mixins/paging_mixin.dart';

typedef RefreshControllerCallback = RefreshController Function();
typedef PageableEntityCallback = PageableEntity Function();
typedef Dao<P> = Future<ResultEntity<P>> Function(PageableEntity pageable);

class NewLogic extends GetxController
    with PagingMixin<PictureEntity, PagePictureEntity> {
  final criteria = SearchPictureTune().obs;

  @override
  onInit() {
    super.onInit();
    criteria.value.precise = null;
  }

  @override
  dao(pageable) => PictureService.paging(pageable, criteria: criteria.value);

  dateRefresh({DateTime dateTime, bool force = false}) {
    criteria.value.date.startDate = dateTime;
    criteria.value.date.endDate = dateTime;
    if (dateTime != null || force) {
      refreshController.requestRefresh(needMove: false);
    }
  }

  showStartDatePicker() async {
    var dateTime = await showDatePicker(
        context: Get.context,
        initialDate: criteria.value?.date?.startDate ?? DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime.now());
    dateRefresh(dateTime: dateTime);
  }
}
