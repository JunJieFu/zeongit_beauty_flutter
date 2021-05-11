import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/mixins/paging_mixin.dart';


class FindLogic extends GetxController
    with PagingMixin<PictureEntity, PagePictureEntity> {

  final dateRange = DateRange().obs;

  @override
  dao(pageable) => PictureService.pagingByRecommend(pageable);
}