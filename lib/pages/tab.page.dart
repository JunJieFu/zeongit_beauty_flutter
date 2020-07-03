import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/pages/find.page.dart';
import 'package:zeongitbeautyflutter/pages/home.page.dart';
import 'package:zeongitbeautyflutter/pages/user.page.dart';
import 'package:zeongitbeautyflutter/widget/header.widget.dart';

import 'new.page.dart';

class TabPage extends StatefulWidget {
  TabPage({Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  TabController _tabController;

  List<TabItemModel> _tabList = [
    TabItemModel(view: HomePage(), tab: Tab(icon: Icon(MdiIcons.home))),
    TabItemModel(view: FindPage(), tab: Tab(icon: Icon(MdiIcons.compass))),
    TabItemModel(
        view: NewPage(), tab: Tab(icon: Icon(MdiIcons.alpha_n_box_outline))),
    TabItemModel(view: UserPage(), tab: Tab(icon: Icon(MdiIcons.account))),
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
        appBar: HeaderWidget(title: Text("首页")),
        body: TabBarView(
            controller: _tabController,
            children: _tabList.map((it) => it.view).toList()),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            tabs: _tabList.map((it) => it.tab).toList(),
            controller: _tabController,
            indicatorColor: Colors.transparent,
          ),
        ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class TabItemModel {
  final Widget view;

  final Widget tab;

  TabItemModel({this.view, this.tab});
}
