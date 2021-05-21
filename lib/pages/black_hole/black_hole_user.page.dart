import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/user/user_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/hooks/paging.hook.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/avatar.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/block_user_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/config.widget.dart';

class BlackHoleUserPage extends HookWidget {
  BlackHoleUserPage({Key? key, this.controller}) : super(key: key);

  final CustomRefreshController? controller;

  @override
  Widget build(BuildContext context) {
    final pagingHookResult =
        usePaging<UserBlackHoleEntity, PageUserBlackHoleEntity>(
            context, (pageable) => UserBlackHoleService.paging(pageable));

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

    emptyWidget() {
      if (meta.value != null &&
          meta.value!.empty &&
          meta.value!.first &&
          meta.value!.last) {
        return TipsPageCard(icon: MdiIcons.account_outline, title: "没有屏蔽用户");
      } else {
        return ListView.builder(
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
                        BlockUserIconBtn(
                          user: user,
                          callback: (user, int state) {
                            list[index].state = state;
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
      child: DefaultRefreshConfiguration(
        child: Obx(
          () => SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: meta.value != null && !meta.value!.last,
            onRefresh: refresh,
            onLoading: () async {
              await changePage(meta.value!.currentPage + 1);
            },
            child: emptyWidget(),
          ),
        ),
      ),
    );
  }

  InkWell _buildAvatar(UserBlackHoleEntity user) {
    var size = 75.0;
    var padding = 8.0;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: AvatarWidget(
          user.avatarUrl,
          user.nickname,
          size: size - padding * 2,
          fit: BoxFit.cover,
          style: AvatarStyle.small50,
        ),
      ),
      onTap: () {
        Get.to(() => UserTabPage(id: user.id));
      },
    );
  }
}
