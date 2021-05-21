import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_user.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class FollowerPage extends HookWidget {
  FollowerPage({Key? key, required this.id, this.controller}) : super(key: key);

  final int id;

  final CustomRefreshController? controller;

  @override
  Widget build(BuildContext context) {
    final pagingHookResult = usePaging<UserInfoEntity, PageUserInfoEntity>(
        context, (pageable) => FollowerService.pagingFollower(pageable, id));

    final refreshController = pagingHookResult.refreshController;
    final list = pagingHookResult.list;
    final meta = pagingHookResult.meta;
    final refresh = pagingHookResult.refresh;
    final changePage = pagingHookResult.changePage;

    useEffect(() {
      controller?.refresh = () {
        refreshController.requestRefresh();
      };
      return () {
        controller?.dispose();
      };
    }, const []);

    return KeepAliveClient(
      child: Scaffold(
          body: Obx(
        () => PageUser(
          meta: meta.value,
          list: list,
          refreshController: refreshController,
          refresh: refresh,
          changePage: changePage,
          emptyChild:
              TipsPageCard(icon: MdiIcons.account_heart_outline, title: "没有粉丝"),
        ),
      )),
    );
  }
}
