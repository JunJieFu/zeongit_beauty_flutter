import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class FootprintPage extends HookWidget {
  FootprintPage({Key key, @required this.id, this.controller})
      : super(key: key);

  final int id;

  final CustomRefreshController controller;

  @override
  Widget build(BuildContext context) {
    var pagingHookResult = usePaging<PictureEntity, PagePictureEntity>(
        context, (pageable) => FootprintService.paging(pageable, id));

    var refreshController = pagingHookResult.refreshController;
    var list = pagingHookResult.list;
    var currPage = pagingHookResult.currPage;
    var refresh = pagingHookResult.refresh;
    var changePage = pagingHookResult.changePage;
    controller?.refresh = () {
      refreshController.value.requestRefresh();
    };

    return Scaffold(
        appBar: AppBar(title: Text("足迹")),
        body: PagePicture(
          currPage: currPage.value,
          list: list.value,
          refreshController: refreshController.value,
          refresh: refresh,
          changePage: changePage,
          emptyChild: TipsPageCard(
              icon: MdiIcons.shoe_print,
              title: "没有作品",
              text: "您可以前往发现浏览一些系统推荐给您的作品哦。"),
        ));
  }
}
