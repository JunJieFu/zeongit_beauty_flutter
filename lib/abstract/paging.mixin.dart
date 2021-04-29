import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/abstract/refresh.mixin.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';

abstract class PagingAbstract<T extends StatefulWidget, M, P extends dynamic>
    extends RefreshAbstract<T> {
  bool loading;
  P currPage;
  List<M> list;
  PageableEntity pageable;

  Future<void> refresh();

  Future<void> changePage(int pageIndex);

  Future<void> paging();

  Future<ResultEntity<dynamic>> dao();
}

mixin PagingMixin<T extends StatefulWidget, M, P extends dynamic>
    on State<T>
    implements PagingAbstract<T, M, P> {
  @override
  bool loading = false;
  @override
  P currPage;
  @override
  List<M> list = [];
  @override
  PageableEntity pageable = PageableEntity();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent -
              scrollController.position.pixels <
          150) {
        changePage(currPage.meta.currentPage + 1);
      }
    });
  }

  @override
  Future<void> refresh() async {
    pageable.page = 1;
    paging();
  }

  @override
  Future<void> changePage(int pageIndex) async {
    if (currPage?.meta != null && currPage.meta.last ||
        currPage?.meta != null && currPage.meta.currentPage >= pageIndex)
      return;
    pageable.page = pageIndex;
    paging();
  }

  @override
  Future<void> paging() async {
    if (loading) return;
    loading = true;
    var result = await dao();
    setState(() {
      currPage = result.data;
      if (currPage.meta.first) {
        scrollController.jumpTo(0);
        list = currPage.items as List<M>;
      } else {
        list.addAll(currPage.items as List<M>);
      }
    });
    loading = false;
  }

  @override
  Future<ResultEntity<dynamic>> dao();
}
