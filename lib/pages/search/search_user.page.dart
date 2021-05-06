import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
  SearchUserPage({Key key, @required this.keyword, this.controller})
      : super(key: key);

  final String keyword;

  final CustomRefreshController controller;

  @override
  Widget build(BuildContext context) {
    var criteria = useState(SearchUserTune());
    criteria.value.nicknameList = keyword;
    var pagingHookResult = usePaging<UserInfoEntity, PageUserInfoEntity>(
        context,
        (pageable) => UserInfoService.paging(pageable, criteria: criteria.value));

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
          body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return SearchPage(keyword: keyword, index: 1);
              }));
            },
            child: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  criteria.value.nicknameList,
                  style: TextStyle(fontSize: 18),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: PageUser(
              currPage: currPage.value,
              list: list.value,
              refreshController: refreshController.value,
              refresh: refresh,
              changePage: changePage,
              followCallback: (index, focus) {
                list.value[index].focus = focus;
                list.notifyListeners();
              },
              emptyChild: TipsPageCard(
                  icon: Icons.search, title: "什么都搜不到哦", text: "您可以再换一个名称搜索哦。"),
            ),
          )
        ],
      )),
    );
  }
}
