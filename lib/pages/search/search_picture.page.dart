import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search.page.dart';
import 'package:zeongitbeautyflutter/pages/search/search_picture_tune.page.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/mixins/paging_mixin.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class SearchPicturePage extends HookWidget {
  SearchPicturePage({Key? key, required this.keyword, this.controller})
      : _criteria = SearchPictureTune(tagList: keyword).obs,
        super(key: key);

  final String keyword;

  final CustomRefreshController? controller;

  final Rx<SearchPictureTune> _criteria;

  @override
  Widget build(BuildContext context) {
    final pagingHookResult = usePaging<PictureEntity, PagePictureEntity>(
        context,
        (pageable) =>
            PictureService.paging(pageable, criteria: _criteria.value));

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

    query(SearchPictureTune tune) {
      _criteria.value = tune;
      refreshController.requestRefresh(needMove: false);
    }

    return KeepAliveClient(
      child: Scaffold(
        body: Obx(() => Stack(
              children: [
                AppBar(
                  automaticallyImplyLeading: false,
                  title: GestureDetector(
                    onTap: () {
                      Get.to(() => SearchPage(keyword: keyword, index: 0));
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
                        Get.to(() => SearchPictureTunePage(
                            params: _criteria.value, callback: query));
                      },
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: kToolbarHeight),
                    child: PagePicture(
                      meta: meta.value,
                      list: list,
                      refreshController: refreshController,
                      refresh: refresh,
                      changePage: changePage,
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
