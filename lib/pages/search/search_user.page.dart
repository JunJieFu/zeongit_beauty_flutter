import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search.page.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/mixins/paging_mixin.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_user.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class SearchUserPage extends StatelessWidget {
  SearchUserPage({Key? key, required this.keyword, this.controller})
      : logic = SearchUserLogic(keyword),
        super(key: key);

  final String keyword;

  final CustomRefreshController? controller;

  final SearchUserLogic logic;

  @override
  Widget build(BuildContext context) {
    controller?.refresh = () {
      logic.refreshController
          .requestRefresh(duration: const Duration(milliseconds: 200));
    };

    return KeepAliveClient(
      child: Scaffold(
          body: Obx(
        () => Stack(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(SearchPage(keyword: keyword, index: 1));
              },
              child: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    logic.keyword,
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                child: PageUser(
                  meta: logic.meta.value,
                  list: logic.list,
                  refreshController: logic.refreshController,
                  refresh: logic.refresh,
                  changePage: logic.changePage,
                  emptyChild: TipsPageCard(
                      icon: Icons.search,
                      title: "什么都搜不到哦",
                      text: "您可以再换一个名称搜索哦。"),
                ))
          ],
        ),
      )),
    );
  }
}

class SearchUserLogic extends GetxController
    with PagingMixin<UserInfoEntity, PageUserInfoEntity> {
  SearchUserLogic(this.keyword) {
    criteria.value.nicknameList = keyword;
  }

  final String keyword;

  final criteria = SearchUserTune().obs;

  query(SearchUserTune tune) {
    criteria.value = tune;
    refreshController.requestRefresh(needMove: false);
  }

  @override
  dao(pageable) => UserInfoService.paging(pageable, criteria: criteria.value);
}
