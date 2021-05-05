import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/black_hole_tag.page.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/black_hole_user.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';

//class BlackHoleTabPage extends StatefulWidget {
//  BlackHoleTabPage({Key key}) : super(key: key);
//
//  @override
//  _BlackHoleTabPageState createState() => _BlackHoleTabPageState();
//}
//
//class _BlackHoleTabPageState extends State<BlackHoleTabPage>
//    with TickerProviderStateMixin {
//  TabController _tabController;
//
//  @override
//  void initState() {
//    super.initState();
//    _tabController = TabController(
//      length: 2,
//      vsync: this, //动画效果的异步处理，默认格式，背下来即可
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        elevation: 1,
//        title: Text("屏蔽设置"),
//        bottom: TabBar(
//          controller: _tabController,
//          tabs: [
//            Tab(icon: Icon(MdiIcons.tag_outline)),
//            Tab(icon: Icon(MdiIcons.account_outline))
//          ], //
//          indicatorColor: StyleConfig.primaryColor
//        ),
//      ),
//      body: TabBarView(
//          controller: _tabController,
//          children: [
//            BlackHoleTagPage(),
//            BlackHoleUserPage()
//          ]),
//    );
//  }
//
//  @override
//  void dispose() {
//    _tabController.dispose();
//    super.dispose();
//  }
//}

class BlackHoleTabPage extends HookWidget{
  @override
  Widget build(BuildContext context) {
    var _tabController = useTabController(initialLength: 2);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("屏蔽设置"),
        bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(icon: Icon(MdiIcons.tag_outline)),
              Tab(icon: Icon(MdiIcons.account_outline))
            ], //
            indicatorColor: StyleConfig.primaryColor
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: [
            BlackHoleTagPage(),
            BlackHoleUserPage()
          ]),
    );
  }
}