import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/pages/find.page.dart';
import 'package:zeongitbeautyflutter/pages/home.page.dart';
import 'package:zeongitbeautyflutter/widget/header.widget.dart';
import 'package:zeongitbeautyflutter/widget/menu.widget.dart';

import 'new.page.dart';

class TabPage extends StatefulWidget {
  TabPage({Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  TabController _tabController;

  List<TabItemModel> _tabList = [
    TabItemModel(view: HomePage(), tab: Tab(icon: Icon(Icons.home))),
    TabItemModel(view: FindPage(), tab: Tab(icon: Icon(Icons.find_in_page))),
    TabItemModel(view: NewPage(), tab: Tab(icon: Icon(Icons.fiber_new)))
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
        appBar: HeaderWidget(title: Text("主页")),
        drawer: Drawer(
          child: MenuWidget(),
        ),
        body: TabBarView(
            controller: _tabController,
            children: _tabList.map((it) => it.view).toList()),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            tabs: _tabList.map((it) => it.tab).toList(),
            controller: _tabController,
            indicatorColor: Colors.transparent,
            indicatorWeight: 1,
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.black45,
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
