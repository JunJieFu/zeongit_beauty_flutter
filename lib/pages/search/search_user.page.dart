import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/abstract/page_user.mixin.dart';
import 'package:zeongitbeautyflutter/abstract/paging.mixin.dart';
import 'package:zeongitbeautyflutter/abstract/refresh.mixin.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/model/dto.model.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: refresh,
              child: emptyWidget()),
        )
      ],
    ));
  }

  @override
  TipsPageCardWidget buildEmptyType() {
    return TipsPageCardWidget(
        icon: Icons.search, title: "什么都搜不到哦", text: "您可以再换一个名称搜索哦。");
  }

  @override
  Future<ResultEntity<PageUserInfoEntity>> dao() =>
      UserService.paging(pageable, criteria: _criteria);
}
