import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/collection_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_collection_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class CollectionPage extends HookWidget {
  CollectionPage({Key? key, required this.id, this.controller})
      : super(key: key);

  final int id;

  final CustomRefreshController? controller;

  @override
  Widget build(BuildContext context) {
    final pagingHookResult = usePaging<CollectionEntity, PageCollectionEntity>(
        context, (pageable) => CollectionService.paging(pageable, id));

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
        () => PageCollection(
          meta: meta.value,
          list: list,
          refreshController: refreshController,
          refresh: refresh,
          changePage: changePage,
          emptyChild: TipsPageCard(
              icon: MdiIcons.star_outline,
              title: "没有作品",
              text: "您可以前往发现浏览一些系统推荐给您的作品哦。"),
        ),
      )),
    );
  }
}
