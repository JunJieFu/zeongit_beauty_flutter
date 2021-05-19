import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/mixins/paging_mixin.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_user.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class CollectionUserPage extends StatelessWidget {
  CollectionUserPage({Key? key, required this.id, this.controller})
      : logic = CollectionUserLogic(id),
        super(key: key);

  final int id;

  final CustomRefreshController? controller;

  final CollectionUserLogic logic;

  @override
  Widget build(BuildContext context) {
    controller?.refresh = () {
      logic.refreshController
          .requestRefresh(duration: const Duration(milliseconds: 200));
    };
    return KeepAliveClient(
        child: Scaffold(
            body: Obx(
      () => PageUser(
        meta: logic.meta.value,
        list: logic.list,
        refreshController: logic.refreshController,
        refresh: logic.refresh,
        changePage: logic.changePage,
        emptyChild: TipsPageCard(
            icon: MdiIcons.star_outline,
            title: "图片没有任何收藏",
            text: "您可以成为第一个收藏的人。"),
      ),
    )));
  }
}

class CollectionUserLogic extends GetxController
    with PagingMixin<UserInfoEntity, PageUserInfoEntity> {
  CollectionUserLogic(this.id);

  final int id;

  @override
  dao(pageable) => CollectionService.pagingUser(pageable, id);
}
