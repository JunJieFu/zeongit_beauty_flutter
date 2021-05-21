import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';

typedef RefreshControllerCallback = RefreshController Function();
typedef PageableEntityCallback = PageableEntity Function();

PagingHookResult<M, P> usePaging<M, P extends dynamic>(BuildContext context,
    Future<ResultEntity<P>> Function(PageableEntity pageable) dao,
    {RefreshControllerCallback? buildController,
    PageableEntityCallback? buildPageable}) {
  final pageable = buildPageable != null ? buildPageable() : PageableEntity();
  final refreshController = buildController != null ? buildController() : RefreshController(initialRefresh: true);
  final loading = false.obs;
  final list = RxList<M>([]);
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

  return PagingHookResult(
    refreshController: refreshController,
    list: list,
    meta: meta,
    pageable: pageable,
    paging: paging,
    refresh: refresh,
    changePage: changePage,
  );
}

class PagingHookResult<M, P extends dynamic> {
  PagingHookResult({
    required this.refreshController,
    required this.list,
    required this.meta,
    required this.pageable,
    required this.paging,
    required this.refresh,
    required this.changePage,
  });

  final RefreshController refreshController;
  final RxList<M> list;
  final Rx<Meta?> meta;
  final PageableEntity pageable;
  final Future<void> Function() paging;
  final Future<void> Function() refresh;
  final Future<void> Function(int pageIndex) changePage;
}
