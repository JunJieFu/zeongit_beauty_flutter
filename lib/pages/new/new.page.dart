import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/pages/new/new.logic.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class NewPage extends StatelessWidget {
  NewPage({Key key, this.controller}) : super(key: key);

  final CustomRefreshController controller;

  final newLogic = NewLogic();

  @override
  Widget build(BuildContext context) {
    final meta = newLogic.meta;
    final refresh = newLogic.refresh;
    final changePage = newLogic.changePage;

    controller?.refresh = () {
      newLogic.refreshController
          .requestRefresh(duration: const Duration(milliseconds: 200));
    };

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("最新"),
          actions: [
            IconButton(
              icon: Icon(MdiIcons.calendar_month_outline),
              onPressed: newLogic.showStartDatePicker,
            ),
            IconButton(
              icon: Icon(MdiIcons.refresh),
              onPressed: () {
                newLogic.dateRefresh(force: true);
              },
            )
          ],
        ),
        body: Obx(
          () => PagePicture(
            meta: meta.value,
            list: newLogic.list,
            refreshController: newLogic.refreshController,
            refresh: refresh,
            changePage: changePage,
            emptyChild: TipsPageCard(
                icon: MdiIcons.compass, title: "没有作品", text: "难道是系统出现什么问题了。"),
          ),
        ));
  }
}
