import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/mixins/paging_mixin.dart';

class SearchPictureLogic extends GetxController
    with PagingMixin<PictureEntity, PagePictureEntity> {
  SearchPictureLogic(this.keyword);

  final criteria = SearchPictureTune().obs;

  final String keyword;

  query(SearchPictureTune tune) {
    criteria.value = tune;
    refreshController.requestRefresh(needMove: false);
  }

  @override
  void onInit() {
    super.onInit();
    criteria.value.tagList = keyword;
  }

  @override
  dao(pageable) =>
      PictureService.paging(pageable, criteria: criteria.value);

}
