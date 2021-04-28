import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/model/index.model.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/black_hole_tag.page.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/black_hole_user.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';

class BlackHoleTabPage extends StatefulWidget {
  BlackHoleTabPage({Key key}) : super(key: key);

  @override
  _BlackHoleTabPageState createState() => _BlackHoleTabPageState();
}

class _BlackHoleTabPageState extends State<BlackHoleTabPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  List<TabItemModel> _tabList = [
    TabItemModel(
        view: BlackHoleTagPage(), tab: Tab(icon: Icon(MdiIcons.tag_outline))),
    TabItemModel(
        view: BlackHoleUserPage(),
        tab: Tab(icon: Icon(MdiIcons.account_outline))),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabList.length,
      vsync: this, //动画效果的异步处理，默认格式，背下来即可
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("屏蔽设置"),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabList.map((it) => it.tab).toList(), //
          indicatorColor: StyleConfig.primaryColor, // <-- total of 2 tabs
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: _tabList.map((it) => it.view).toList()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
