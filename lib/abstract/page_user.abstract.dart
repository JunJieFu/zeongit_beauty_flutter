import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zeongitbeautyflutter/abstract/refresh.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/widget/user_list_normal.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

abstract class PageUserAbstract<T extends StatefulWidget>
    extends RefreshAbstract<T> {
  bool loading = false;
  GlobalKey<UserListNormalWidgetState> listWidgetKey =
      GlobalKey<UserListNormalWidgetState>();
  PageUserInfoEntity currPage;
  List<UserInfoEntity> list = [];
  PageableEntity pageable = PageableEntity();

  @override
  void initState() {
    super.initState();
    scrollController = listWidgetKey?.currentState?.scrollController;
  }

  Future<void> refresh() async {
    pageable.page = 1;
    paging();
  }

  Future<void> changePage(int pageIndex) async {
    if (currPage?.meta != null && currPage.meta.last ||
        currPage?.meta != null && currPage.meta.currentPage >= pageIndex)
      return;
    pageable.page = pageIndex;
    paging();
  }

  Future<void> paging() async {
    if (loading) return;
    loading = true;
    var result = await dao();
    setState(() {
      currPage = result.data;
      if (currPage.meta.first) {
        listWidgetKey?.currentState?.goTo();
        list = currPage.items;
      } else {
        list.addAll(currPage.items);
      }
    });
    loading = false;
  }

  Widget emptyWidget() {
    if (currPage?.meta != null &&
        currPage.meta.empty &&
        currPage.meta.first &&
        currPage.meta.last) {
      return ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [buildEmptyType()]);
    } else {
      return buildListWaterFall();
    }
  }

  UserListNormalWidget buildListWaterFall() {
    return UserListNormalWidget(
        key: listWidgetKey,
        currPage: currPage,
        list: list,
        changePage: changePage);
  }

  TipsPageCardWidget buildEmptyType();

  Future<ResultEntity<PageUserInfoEntity>> dao();
}
