import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/model/index.model.dart';
import 'package:zeongitbeautyflutter/pages/find.page.dart';
import 'package:zeongitbeautyflutter/pages/home.page.dart';
import 'package:zeongitbeautyflutter/pages/new.page.dart';
import 'package:zeongitbeautyflutter/pages/user.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/header.widget.dart';

class TabPage extends StatefulWidget {
  TabPage({Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  TabController tabController;

  List<TabItemModel> tabList = [
    TabItemModel(view: HomePage(), tab: Tab(child: Text("123"))),
    TabItemModel(view: FindPage(), tab: Tab(icon: Icon(MdiIcons.compass))),
    TabItemModel(
        view: NewPage(), tab: Tab(icon: Icon(MdiIcons.alpha_n_box_outline))),
    TabItemModel(view: UserPage(), tab: Tab(icon: Icon(MdiIcons.account))),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: tabList.length,
      vsync: this, //动画效果的异步处理，默认格式，背下来即可
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderWidget(title: Text("首页")),
        body: TabBarView(
            controller: tabController,
            children: tabList.map((it) => it.view).toList()),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            tabs: tabList.map((it) => it.tab).toList(),
            controller: tabController,
            indicatorColor: Colors.transparent,
          ),
        ));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
