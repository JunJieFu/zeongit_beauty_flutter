import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

class FollowerPage extends HookWidget {
  FollowerPage({Key? key, required this.id, this.controller})
      : logic = FollowerLogic(id, controller),
        super(key: key);

  final int id;

  final CustomRefreshController? controller;

  final FollowerLogic logic;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      logic.onStart();
      return logic.onDelete;
    }, const []);

    return KeepAliveClient(
      child: Scaffold(
          body: Obx(
        () => PageUser(
          meta: logic.meta.value,
          list: logic.list,
          refreshController: logic.refreshController,
          refresh: logic.refresh,
          changePage: logic.changePage,
          emptyChild:
              TipsPageCard(icon: MdiIcons.account_heart_outline, title: "没有粉丝"),
        ),
      )),
    );
  }
}

class FollowerLogic extends GetxController
    with PagingMixin<UserInfoEntity, PageUserInfoEntity> {
  FollowerLogic(this.id, this.controller);

  final int id;

  final CustomRefreshController? controller;

  @override
  dao(pageable) => FollowerService.pagingFollower(pageable, id);

  @override
  void onInit() {
    super.onInit();
    controller?.refresh = () {
      refreshController.requestRefresh(
          duration: const Duration(milliseconds: 200));
    };
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }
}
