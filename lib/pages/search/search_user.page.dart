import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/search/search.page.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/page_user.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class SearchUserPage extends HookWidget {
  SearchUserPage({Key? key, required this.keyword, this.controller})
      : _criteria = SearchUserTune(nicknameList: keyword).obs,
        super(key: key);

  final String keyword;

  final CustomRefreshController? controller;

  final Rx<SearchUserTune> _criteria;

  @override
  Widget build(BuildContext context) {
    final pagingHookResult = usePaging<UserInfoEntity, PageUserInfoEntity>(
        context,
        (pageable) =>
            UserInfoService.paging(pageable, criteria: _criteria.value));

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

    query(SearchUserTune tune) {
      _criteria.value = tune;
      refreshController.requestRefresh(needMove: false);
    }

    return KeepAliveClient(
      child: Scaffold(
          body: Obx(
        () => Stack(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => SearchPage(keyword: keyword, index: 1));
              },
              child: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    keyword,
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                child: PageUser(
                  meta: meta.value,
                  list: list,
                  refreshController: refreshController,
                  refresh: refresh,
                  changePage: changePage,
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
