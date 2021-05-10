import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search.page.dart';
import 'package:zeongitbeautyflutter/pages/search/search_picture.logic.dart';
import 'package:zeongitbeautyflutter/pages/search/search_picture_tune.page.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class SearchPicturePage extends StatelessWidget {
  SearchPicturePage({Key key, @required this.keyword, this.controller})
      : super(key: key);

  final String keyword;

  final CustomRefreshController controller;

  SearchPictureLogic get logic => Get.put(SearchPictureLogic(keyword));

  @override
  Widget build(BuildContext context) {
    controller?.refresh = () {
      logic.refreshController
          .requestRefresh(duration: const Duration(milliseconds: 200));
    };

    return KeepAliveClient(
      child: Obx(
        () => Scaffold(
            body: Stack(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: GestureDetector(
                onTap: () {
                  Get.to(SearchPage(keyword: keyword, index: 0));
                },
                child: Text(
                  keyword,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(MdiIcons.tune),
                  onPressed: () {
                    Get.to(SearchPictureTunePage(
                        params: logic.criteria.value, callback: logic.query));
                  },
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                child: PagePicture(
                  meta: logic.meta.value,
                  list: logic.list,
                  refreshController: logic.refreshController,
                  refresh: logic.refresh,
                  changePage: logic.changePage,
                  emptyChild: TipsPageCard(
                      icon: MdiIcons.compass,
                      title: "什么都搜不到哦",
                      text: "您可以再换一些标签搜索哦。"),
                ))
          ],
        )),
      ),
    );
  }
}
