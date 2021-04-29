import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/abstract/paging.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/user/user_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/avatar.widget.dart';
import 'package:zeongitbeautyflutter/widget/btn/block_user_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

class BlackHoleUserPage extends StatefulWidget {
  @override
  _BlackHoleUserPageState createState() => _BlackHoleUserPageState();
}

class _BlackHoleUserPageState extends PagingAbstract<
    BlackHoleUserPage,
    UserBlackHoleEntity,
    PageUserBlackHoleEntity> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        key: refreshIndicatorKey, onRefresh: refresh, child: _emptyWidget());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<ResultEntity<PageUserBlackHoleEntity>> dao() =>
      UserBlackHoleService.paging(pageable);

  Widget _emptyWidget() {
    if (currPage?.meta != null &&
        currPage.meta.empty &&
        currPage.meta.first &&
        currPage.meta.last) {
      return TipsPageCardWidget(
          icon: MdiIcons.account_outline, title: "没有屏蔽用户");
    } else {
      return ListView.builder(
          controller: scrollController,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            UserBlackHoleEntity user = list[index];
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: StyleConfig.gap * 3,
                      vertical: StyleConfig.gap * 2),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      _buildAvatar(user),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: StyleConfig.gap * 2),
                          child: Text(user.nickname),
                        ),
                      ),
                      BlockUserIconBtnWidget(
                        user: user,
                        callback: (user, int state) {
                          setState(() {
                            list[index].state = state;
                          });
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

  InkWell _buildAvatar(UserBlackHoleEntity user) {
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
