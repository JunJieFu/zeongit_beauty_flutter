import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/user/user_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/avatar.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/block_user_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class BlackHoleUserPage extends HookWidget {
  BlackHoleUserPage({Key key, this.controller}) : super(key: key);

  final CustomRefreshController controller;

  @override
  Widget build(BuildContext context) {
    var pagingHookResult =
        usePaging<UserBlackHoleEntity, PageUserBlackHoleEntity>(
            context, (pageable) => UserBlackHoleService.paging(pageable));

    var refreshController = pagingHookResult.refreshController;
    var list = pagingHookResult.list;
    var currPage = pagingHookResult.currPage;
    var refresh = pagingHookResult.refresh;
    var changePage = pagingHookResult.changePage;
    controller?.refresh = () {
      refreshController.value.requestRefresh();
    };
    Widget _emptyWidget() {
      if (currPage.value?.meta != null &&
          currPage.value.meta.empty &&
          currPage.value.meta.first &&
          currPage.value.meta.last) {
        return TipsPageCard(icon: MdiIcons.account_outline, title: "没有屏蔽用户");
      } else {
        return ListView.builder(
            itemCount: list.value.length,
            itemBuilder: (BuildContext context, int index) {
              UserBlackHoleEntity user = list.value[index];
              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: StyleConfig.gap * 3,
                        vertical: StyleConfig.gap * 2),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        _buildAvatar(context, user),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: StyleConfig.gap * 2),
                            child: Text(user.nickname),
                          ),
                        ),
                        BlockUserIconBtn(
                          user: user,
                          callback: (user, int state) {
                            list.value[index].state = state;
                            list.notifyListeners();
                          },
                        )
                      ],
                    ),
                  ),
                  Divider(height: 1)
                ],
              );
            });
      }
    }

    return KeepAliveClient(
      child: SmartRefresher(
        controller: refreshController.value,
        enablePullDown: true,
        enablePullUp: currPage.value != null && !currPage.value.meta.last,
        onRefresh: refresh,
        onLoading: () async {
          await changePage(currPage.value.meta.currentPage + 1);
        },
        child: _emptyWidget(),
      ),
    );
  }

  InkWell _buildAvatar(BuildContext context, UserBlackHoleEntity user) {
    var size = 75.0;
    var padding = 8.0;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: AvatarWidget(
          user?.avatarUrl,
          user?.nickname,
          size: size - padding * 2,
          fit: BoxFit.cover,
          style: AvatarStyle.small50,
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return UserTabPage(id: user.id);
        }));
      },
    );
  }
}
