import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class WorksPage extends HookWidget {
  WorksPage({Key key, @required this.id, this.controller}) : super(key: key);

  final int id;

  final CustomRefreshController controller;


  @override
  Widget build(BuildContext context) {
    var pagingHookResult = usePaging<PictureEntity, PagePictureEntity>(
        context,
            (pageable) =>
                WorksService.paging(pageable, id));

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
          body: PagePicture(
            currPage: currPage.value,
            list: list.value,
            refreshController: refreshController.value,
            refresh: refresh,
            changePage: changePage,
            emptyChild: TipsPageCard(
                icon: MdiIcons.image_outline, title: "没有作品", text: "可以上传一些作品到我们哦。"),
          )),
    );
  }
}
