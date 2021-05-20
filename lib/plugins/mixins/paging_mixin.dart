import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';

typedef RefreshControllerCallback = RefreshController Function();
typedef PageableEntityCallback = PageableEntity Function();

abstract class Paging<M, P extends dynamic> {
  final refreshController = RefreshController(initialRefresh: true);
  final pageable = PageableEntity();
  final loading = false.obs;
  final list = RxList<M>([]);
  final meta = Rx<Meta?>(null);
  Future<ResultEntity<P>> dao(PageableEntity pageable);
}

mixin PagingMixin<M, P extends dynamic> on GetxController
    implements Paging<M, P> {
  @override
  final refreshController = RefreshController(initialRefresh: true);
  @override
  final pageable = PageableEntity();
  @override
  final loading = false.obs;
  @override
  final list = RxList<M>([]);
  @override
  final meta = Rx<Meta?>(null);

  Future<void> paging() async {
    if (loading.value) return;
    loading.value = true;
    var result = await dao(pageable);
    meta.value = result.data.meta as Meta;
    if (meta.value!.first) {
      refreshController.position?.jumpTo(0);
      list.clear();
      list.addAll(result.data.items as List<M>);
    } else {
      list.addAll(result.data.items as List<M>);
    }
    loading.value = false;
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  Future<void> refresh() async {
    pageable.page = 1;
    paging();
  }

  Future<void> changePage(int pageIndex) async {
    if (meta.value != null && meta.value!.last ||
        meta.value != null && meta.value!.currentPage >= pageIndex) return;
    pageable.page = pageIndex;
    paging();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
