import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/pages/user/collection.page.dart';
import 'package:zeongitbeautyflutter/pages/user/following.page.dart';
import 'package:zeongitbeautyflutter/pages/user/following_new.page.dart';
import 'package:zeongitbeautyflutter/plugins/controllers/refresh.controller.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class ConvenientTabPage extends StatefulWidget {
  ConvenientTabPage({Key key}) : super(key: key);

  @override
  ConvenientTabPageState createState() => ConvenientTabPageState();
}

class ConvenientTabPageState extends State<ConvenientTabPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  GlobalKey<FollowingNewPageState> followingNewPageKey =
      GlobalKey<FollowingNewPageState>();
  GlobalKey<CollectionPageState> collectionPageKey =
      GlobalKey<CollectionPageState>();
  var _followingController = CustomRefreshController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this, //动画效果的异步处理，默认格式，背下来即可
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(builder: (ctx, UserState userState, child) {
      if (userState.info == null) {
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
                tabs: _buildTabList(),
                controller: _tabController,
              ),
              elevation: 0,
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                FollowingNewPage(key: followingNewPageKey),
                CollectionPage(key: collectionPageKey, id: userState.info.id),
                FollowingPage(controller: _followingController, id: userState.info.id),
              ],
            ));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _buildTabList() {
    return [Tab(text: "动态"), Tab(text: "收藏"), Tab(text: "关注")];
  }

  externalRefresh() {
    if (_tabController.index == 0)
      followingNewPageKey?.currentState?.externalRefresh();
    if (_tabController.index == 1)
      collectionPageKey?.currentState?.externalRefresh();
    if (_tabController.index == 2)
      _followingController.refresh();
  }
}
