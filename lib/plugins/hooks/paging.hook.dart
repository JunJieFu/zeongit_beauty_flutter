import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';

typedef RefreshControllerCallback = RefreshController Function();
typedef PageableEntityCallback = PageableEntity Function();

PagingHookResult<M, P> usePaging<M, P extends dynamic>(BuildContext context,
    Future<ResultEntity<P>> Function(PageableEntity pageable) dao,
    {RefreshControllerCallback? buildController,
    PageableEntityCallback? buildPageable}) {
  var refreshController = useState(buildController != null
      ? buildController()
      : RefreshController(initialRefresh: true));
  bool loading = false;
  var currPage = useState<P?>(null);
  var list = useState<List<M>>([]);
  PageableEntity pageable =
      buildPageable != null ? buildPageable() : PageableEntity();

  Future<void> paging() async {
    if (loading) return;
    loading = true;
    var result = await dao(pageable);
    currPage.value = result.data;
    if (currPage.value.meta.first) {
      refreshController.value.position?.jumpTo(0);
      list.value = currPage.value.items as List<M>;
    } else {
      list.value.addAll(currPage.value.items as List<M>);
    }
    loading = false;
    refreshController.value.refreshCompleted();
    refreshController.value.loadComplete();
  }

  Future<void> refresh() async {
    pageable.page = 1;
    paging();
  }

  Future<void> changePage(int pageIndex) async {
    if (currPage.value?.meta != null && currPage.value.meta.last ||
        currPage.value?.meta != null &&
            currPage.value.meta.currentPage >= pageIndex) return;
    pageable.page = pageIndex;
    paging();
  }

  return PagingHookResult(
    refreshController: refreshController,
    list: list,
    currPage: currPage,
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
    required this.currPage,
    required this.pageable,
    required this.paging,
    required this.refresh,
    required this.changePage,
  });

  ValueNotifier<RefreshController> refreshController;
  ValueNotifier<List<M>> list;
  ValueNotifier<P?> currPage;
  PageableEntity pageable;
  Future<void> Function() paging;
  Future<void> Function() refresh;
  Future<void> Function(int pageIndex) changePage;
}
