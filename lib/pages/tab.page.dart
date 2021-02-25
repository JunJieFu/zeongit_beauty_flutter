import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/pages/find.page.dart';
import 'package:zeongitbeautyflutter/pages/home.page.dart';
import 'package:zeongitbeautyflutter/pages/new.page.dart';
import 'package:zeongitbeautyflutter/pages/user.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/widget/header.widget.dart';

import 'find.page.dart';
import 'home.page.dart';
import 'new.page.dart';

class TabPage extends StatefulWidget {
  TabPage({Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  TabController tabController;
  GlobalKey<HomePageState> homePageStateKey = GlobalKey<HomePageState>();
  GlobalKey<FindPageState> findPageStateKey = GlobalKey<FindPageState>();
  GlobalKey<NewPageState> newPageStateKey = GlobalKey<NewPageState>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this, //动画效果的异步处理，默认格式，背下来即可
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderWidget(title: Text("首页")),
        body:
            TabBarView(controller: tabController, children: buildTabViewList()),
        bottomNavigationBar: BottomAppBar(
            child: TabBar(
                tabs: buildTabList(),
                controller: tabController,
                indicatorColor: Colors.transparent,
                onTap: (int index) {
                  if (!tabController.indexIsChanging) {
                    switch (index) {
                      case 0:
                        {
                          homePageStateKey.currentState?.parentTabTap();
                        }
                        break;
                      case 1:
                        {
                          findPageStateKey.currentState?.parentTabTap();
                        }
                        break;
                      case 2:
                        {
                          newPageStateKey.currentState?.parentTabTap();
                        }
                        break;
                      default:
                        {}
                        break;
                    }
                  }
                })));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  buildTabList() {
    return [
      Tab(
        child: Icon(MdiIcons.home),
      ),
      Tab(icon: Icon(MdiIcons.compass)),
      Tab(icon: Icon(MdiIcons.alpha_n_box_outline)),
      Tab(icon: Icon(MdiIcons.account))
    ];
  }

  buildTabViewList() {
    return [
      HomePage(key: homePageStateKey),
      FindPage(key: findPageStateKey),
      NewPage(key: newPageStateKey),
      UserPage()
    ];
  }
}
