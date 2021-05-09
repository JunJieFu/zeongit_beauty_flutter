import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/pages/user/user_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/avatar.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/follow_btn.widget.dart';

typedef ChangePageCallback = Future<void> Function(int pageIndex);
typedef FollowCallback = void Function(int index, int focus);

class PageUser extends StatelessWidget {
  PageUser({
    Key key,
    @required this.emptyChild,
    @required this.currPage,
    @required this.list,
    @required this.refreshController,
    @required this.refresh,
    @required this.changePage,
    @required this.followCallback,
  }) : super(key: key);
  final Widget emptyChild;
  final PageUserInfoEntity currPage;
  final List<UserInfoEntity> list;
  final RefreshController refreshController;
  final VoidCallback refresh;
  final ChangePageCallback changePage;
  final FollowCallback followCallback;

  _buildListWaterFall() {
    return ListView.builder(
        itemCount: list?.length,
        itemBuilder: (BuildContext context, int index) {
          var user = list[index];
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
                    FollowBtn(
                      user: user,
                      callback: (user, focus) {
                        followCallback(index, focus);
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

  _buildAvatar(UserInfoEntity user) {
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
        Get.to(UserTabPage(id: user.id));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buildIf() {
      if (currPage?.meta != null &&
          currPage.meta.empty &&
          currPage.meta.first &&
          currPage.meta.last) {
        return ListView(
            physics: AlwaysScrollableScrollPhysics(), children: [emptyChild]);
      } else {
        return _buildListWaterFall();
      }
    }

    return SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        enablePullUp: currPage != null && !currPage.meta.last,
        onRefresh: refresh,
        onLoading: () async {
          await changePage(currPage.meta.currentPage + 1);
        },
        child: buildIf());
  }
}
