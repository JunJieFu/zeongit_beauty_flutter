import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor.provider.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/list_user.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class VisitorFollowerPage extends StatefulWidget {
  @override
  _VisitorFollowerPageState createState() => _VisitorFollowerPageState();
}

class _VisitorFollowerPageState extends State<VisitorFollowerPage>
    with AutomaticKeepAliveClientMixin {
  bool _loading = false;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;
  PageUserInfoEntity _page;
  List<UserInfoEntity> _list = [];
  PageableEntity _pageable = PageableEntity();
  int _targetId;

  Future<void> _refresh() async {
    _paging(0);
  }

  Future<void> _paging(int page) async {
    _pageable.page = page;
    if (this._loading || (this._page != null && this._page.last)) return;
    _loading = true;
    var result =
        await UserService.pagingFollower(_pageable, targetId: _targetId);
    setState(() {
      _page = result.data;
      if (page == 0) {
        _list = _page.content;
      } else {
        _list.addAll(_page.content);
      }
    });
    _loading = false;
  }

  @override
  void initState() {
    super.initState();
    _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<VisitorState>(
        builder: (ctx, VisitorState visitorState, child) {
      _targetId = visitorState.info.id;
      return RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: _emptyWidget());
    });
  }

  Widget _emptyWidget() {
    if (_page != null && _page.empty && _page.first && _page.last) {
      return TipsPageCardWidget(
          icon: MdiIcons.star_outline,
          title: "没有作品",
          text: "您可以前往发现浏览一些系统推荐给您的作品哦。",
          btnDesc: "前往发现");
    } else {
      return ListUserWidget(page: _page, list: _list, paging: _paging);
    }
  }

  @override
  bool get wantKeepAlive => true;
}