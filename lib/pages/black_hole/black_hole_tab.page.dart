import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/black_hole_tag.page.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/black_hole_user.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';

class BlackHoleTabPage extends HookWidget{
  final _primaryColor = Get.theme.primaryColor;

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("屏蔽设置"),
        bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(icon: Icon(MdiIcons.tag_outline)),
              Tab(icon: Icon(MdiIcons.account_outline))
            ], //
            indicatorColor: _primaryColor
        ),
      ),
      body: TabBarView(
          controller: tabController,
          children: [
            BlackHoleTagPage(),
            BlackHoleUserPage()
          ]),
    );
  }
}