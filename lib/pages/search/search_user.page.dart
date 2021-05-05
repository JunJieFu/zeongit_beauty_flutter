import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/mixins/paging.mixin.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class SearchUserPage extends StatefulWidget {
  SearchUserPage({Key key, @required this.keyword}) : super(key: key);

  final String keyword;

  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage>
    with
        AutomaticKeepAliveClientMixin,
        RefreshMixin,
        PagingMixin<SearchUserPage, UserInfoEntity, PageUserInfoEntity>,
        PageUserMixin {
  SearchUserTune _criteria = SearchUserTune();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _criteria.nicknameList = widget.keyword;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Stack(
      children: [
        AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              _criteria.nicknameList,
              style: TextStyle(fontSize: 18),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 56),
          child: SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: currPage != null && !currPage.meta.last,
            onRefresh: refresh,
            onLoading: () async {
              await changePage(currPage.meta.currentPage + 1);
            },
            child: emptyWidget(),
          ),
        )
      ],
    ));
  }

  @override
  Future<ResultEntity<PageUserInfoEntity>> dao() =>
      UserService.paging(pageable, criteria: _criteria);

  @override
  TipsPageCard buildEmptyType() {
    return TipsPageCard(
        icon: Icons.search, title: "什么都搜不到哦", text: "您可以再换一个名称搜索哦。");
  }
}
