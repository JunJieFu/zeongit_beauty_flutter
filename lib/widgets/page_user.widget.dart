import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/pages/user/user_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/avatar.widget.dart';
import 'package:zeongitbeautyflutter/provider/user_info.logic.dart';
import 'package:zeongitbeautyflutter/widgets/btn/follow_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/follow_icon_btn.widget.dart';

typedef ChangePageCallback = Future<void> Function(int pageIndex);
typedef FollowCallback = void Function(int index, int focus);

class PageUser extends StatelessWidget {
  PageUser({
    Key key,
    @required this.emptyChild,
    @required this.meta,
    @required this.list,
    @required this.refreshController,
    @required this.refresh,
    @required this.changePage,
    this.followCallback,
  }) : super(key: key);
  final Widget emptyChild;
  final Meta meta;
  final List<UserInfoEntity> list;
  final RefreshController refreshController;
  final VoidCallback refresh;
  final ChangePageCallback changePage;
  final FollowCallback followCallback;

  @override
  Widget build(BuildContext context) {
    var size = 75.0;
    var padding = 8.0;
    return SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        enablePullUp: meta != null && !meta.last,
        onRefresh: refresh,
        onLoading: () async {
          await changePage(meta.currentPage + 1);
        },
        child: meta != null && meta.empty && meta.first && meta.last
            ? ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [emptyChild])
            : ListView.builder(
                itemCount: list?.length,
                itemBuilder: (BuildContext context, int index) {
                  UserInfoEntity userInfo = list[index];
                  UserInfoLogic logic;
                  try {
                    logic = Get.find(
                        tag: USER_INFO_LOGIC_TAG_PREFIX +
                            userInfo.id.toString());
                    logic.set(userInfo);
                  } catch (e) {
                    logic = Get.put(UserInfoLogic(userInfo),
                        tag: USER_INFO_LOGIC_TAG_PREFIX +
                            userInfo.id.toString());
                  }
                  return Obx(
                    () => Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: StyleConfig.gap * 3,
                              vertical: StyleConfig.gap * 2),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: <Widget>[
                              InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(size / 2)),
                                child: Padding(
                                  padding: EdgeInsets.all(padding),
                                  child: AvatarWidget(
                                    logic.info?.avatarUrl,
                                    logic.info?.nickname,
                                    size: size - padding * 2,
                                    fit: BoxFit.cover,
                                    style: AvatarStyle.small50,
                                  ),
                                ),
                                onTap: () {
                                  print(123);
                                  Get.to(UserTabPage(id: logic.info.id));
                                },
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: StyleConfig.gap * 2),
                                  child: Text(logic.info.nickname),
                                ),
                              ),
                              FollowBtn(
                                id: logic.info.id,
                              )
                            ],
                          ),
                        ),
                        Divider(height: 1)
                      ],
                    ),
                  );
                }));
  }
}
