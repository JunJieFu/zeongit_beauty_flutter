import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/black_hole_tag.page.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/black_hole_user.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';

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