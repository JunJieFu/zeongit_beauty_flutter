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

class FindLogic extends GetxController
    with PagingMixin<PictureEntity, PagePictureEntity> {
  FindLogic();

  final dateRange = DateRange().obs;

  @override
  var dao = (pageable) => PictureService.pagingByRecommend(pageable);
}
