import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/mixins/paging_mixin.dart';

class SearchPictureLogic extends GetxController
    with PagingMixin<PictureEntity, PagePictureEntity> {
  final criteria = SearchPictureTune().obs;

  final String keyword;

  SearchPictureLogic(this.keyword) {
    criteria.value.tagList = keyword;
  }

  query(SearchPictureTune tune) {
    criteria.value = tune;
    refreshController.requestRefresh(needMove: false);
  }

  @override
  dao(pageable) => PictureService.paging(pageable, criteria: criteria.value);
}
