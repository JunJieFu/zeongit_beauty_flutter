import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/pages/convenient/collection.page.dart';
import 'package:zeongitbeautyflutter/pages/convenient/following_new.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

import 'following.page.dart';

class ConvenientTabPage extends StatefulWidget {
  ConvenientTabPage({Key key}) : super(key: key);

  @override
  _ConvenientTabPageState createState() => _ConvenientTabPageState();
}

class _ConvenientTabPageState extends State<ConvenientTabPage>
    with TickerProviderStateMixin {
  TabController _tabController;

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
                FollowingNewPage(),
                CollectionPage(id: userState.info.id),
                FollowingPage(id: userState.info.id),
              ],
            ));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  _buildTabList() {
    return [Tab(text: "动态"), Tab(text: "收藏"), Tab(text: "关注")];
  }
}
