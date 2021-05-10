import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/pages/user/works.logic.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class WorksPage extends StatelessWidget {
  WorksPage({Key key, @required this.id, this.controller}) : super(key: key);

  final int id;

  final CustomRefreshController controller;

  WorksLogic get logic => Get.put(WorksLogic(id));

  @override
  Widget build(BuildContext context) {
    controller?.refresh = () {
      logic.refreshController
          .requestRefresh(duration: const Duration(milliseconds: 200));
    };

    return KeepAliveClient(
      child: Scaffold(
          body: Obx(
        () => PagePicture(
          meta: logic.meta.value,
          list: logic.list,
          refreshController: logic.refreshController,
          refresh: logic.refresh,
          changePage: logic.changePage,
          emptyChild: TipsPageCard(
              icon: MdiIcons.compass, title: "没有作品", text: "可以上传一些作品到我们哦。"),
        ),
      )),
    );
  }
}
