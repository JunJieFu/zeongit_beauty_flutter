import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zeongitbeautyflutter/abstract/paging.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';
import 'package:zeongitbeautyflutter/widget/user_list_normal.widget.dart';

abstract class PageUserAbstract<T extends StatefulWidget>
    extends PagingAbstract<T, UserInfoEntity, PageUserInfoEntity> {
  Widget emptyWidget() {
    if (currPage?.meta != null &&
        currPage.meta.empty &&
        currPage.meta.first &&
        currPage.meta.last) {
      return ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [buildEmptyType()]);
    } else {
      return _buildListWaterFall();
    }
  }

  TipsPageCardWidget buildEmptyType();

  UserListNormalWidget _buildListWaterFall() {
    return UserListNormalWidget(
        currPage: currPage,
        list: list,
        controller: scrollController,
        changePage: changePage);
  }
}
