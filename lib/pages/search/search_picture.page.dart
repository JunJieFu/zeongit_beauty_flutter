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
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_picture.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class SearchPicturePage extends HookWidget {
  SearchPicturePage({Key key, @required this.keyword, this.controller})
      : super(key: key);

  final String keyword;

  final CustomRefreshController controller;

  @override
  Widget build(BuildContext context) {
    var criteria = useState(SearchPictureTune());

    criteria.value.tagList = keyword;
    var pagingHookResult = usePaging<PictureEntity, PagePictureEntity>(
        context,
        (pageable) =>
            PictureService.paging(pageable, criteria: criteria.value));

    var refreshController = pagingHookResult.refreshController;
    var list = pagingHookResult.list;
    var currPage = pagingHookResult.currPage;
    var refresh = pagingHookResult.refresh;
    var changePage = pagingHookResult.changePage;

    controller?.refresh = () {
      refreshController.value
          .requestRefresh(duration: const Duration(milliseconds: 200));
    };

    _query(SearchPictureTune _) {
      criteria.value = _;
      refreshController.value.requestRefresh(needMove: false);
    }

    return KeepAliveClient(
      child: Scaffold(
          body: Stack(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: GestureDetector(
              onTap: () {
                Get.to(SearchPage(keyword: keyword, index: 0));
              },
              child: Text(
                criteria.value.tagList,
                style: TextStyle(fontSize: 18),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(MdiIcons.tune),
                onPressed: () {
                  Get.to(SearchPictureTunePage(
                      params: criteria.value, callback: _query));
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: PagePicture(
              currPage: currPage.value,
              list: list.value,
              refreshController: refreshController.value,
              refresh: refresh,
              changePage: changePage,
              emptyChild: TipsPageCard(
                  icon: Icons.search, title: "什么都搜不到哦", text: "您可以再换一些标签搜索哦。"),
            ),
          )
        ],
      )),
    );
  }
}
