import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_user.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class FootprintUserPage extends HookWidget {
  FootprintUserPage({Key key, @required this.id, this.controller})
      : super(key: key);

  final int id;

  final CustomRefreshController controller;

  @override
  Widget build(BuildContext context) {
    var pagingHookResult = usePaging<UserInfoEntity, PageUserInfoEntity>(
        context, (pageable) => FootprintService.pagingUser(pageable, id));

    var refreshController = pagingHookResult.refreshController;
    var list = pagingHookResult.list;
    var currPage = pagingHookResult.currPage;
    var refresh = pagingHookResult.refresh;
    var changePage = pagingHookResult.changePage;

    controller?.refresh = () {
      refreshController.value
          .requestRefresh(duration: const Duration(milliseconds: 200));
    };

    return KeepAliveClient(
      child: Scaffold(
          body: PageUser(
        currPage: currPage.value,
        list: list.value,
        refreshController: refreshController.value,
        refresh: refresh,
        changePage: changePage,
        followCallback: (index, focus) {
          list.value[index].focus = focus;
          list.notifyListeners();
        },
        emptyChild: TipsPageCard(
            icon: MdiIcons.shoe_print,
            title: "图片没有任何足迹",
            text: "您可以成为第一个留下脚印的人。"),
      )),
    );
  }
}