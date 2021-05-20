import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/pages/user/collection.page.dart';
import 'package:zeongitbeautyflutter/pages/user/following.page.dart';
import 'package:zeongitbeautyflutter/pages/user/following_new.page.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/provider/account.logic.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class ConvenientTabPage extends HookWidget {
  ConvenientTabPage({Key? key, this.controller}) : super(key: key);

  final CustomRefreshController? controller;

  final _accountLogic = Get.find<AccountLogic>();

  final _tabList = [Tab(text: "动态"), Tab(text: "收藏"), Tab(text: "关注")];

  final _followingNewController = CustomRefreshController();

  final _collectionController = CustomRefreshController();

  final _followingController = CustomRefreshController();

  @override
  Widget build(BuildContext context) {
    final tabController =
        useTabController(initialLength: _tabList.length);
    useEffect(() {
      controller?.refresh = () {
        if (tabController.index == 0 && _followingNewController.refresh != null)
          _followingNewController.refresh!();
        if (tabController.index == 1 && _collectionController.refresh != null)
          _collectionController.refresh!();
        if (tabController.index == 2 && _followingController.refresh != null)
          _followingController.refresh!();
      };
      return controller?.dispose;
    }, const []);
    return Obx(() {
      if (_accountLogic.info == null) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text("速览"),
            ),
            body: SignInPageCardWidget(
                icon: MdiIcons.image_outline,
                title: "您的速览主页",
                text: "请先登录，才能开启便捷操作。"));
      } else {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: _tabList,
                controller: tabController,
              ),
              elevation: 0,
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                FollowingNewPage(controller: _followingNewController),
                CollectionPage(
                    controller: _collectionController,
                    id: _accountLogic.info!.id),
                FollowingPage(
                    controller: _followingController,
                    id: _accountLogic.info!.id),
              ],
            ));
      }
    });
  }
}
