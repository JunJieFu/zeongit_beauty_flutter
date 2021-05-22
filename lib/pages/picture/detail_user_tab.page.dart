import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/pages/picture/collection_user.page.dart';
import 'package:zeongitbeautyflutter/pages/picture/footprint_user.page.dart';

class DetailUserTabPage extends HookWidget {
  DetailUserTabPage({Key? key, required this.picture, required this.index})
      : super(key: key);

  final PictureEntity picture;

  final int index;

  final _tabList = [Tab(text: "阅读"), Tab(text: "喜欢")];

  @override
  Widget build(BuildContext context) {
    var tabController =
        useTabController(initialLength: _tabList.length, initialIndex: index);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: _tabList,
            controller: tabController,
          )),
      body: TabBarView(
        controller: tabController,
        children: [
          FootprintUserPage(id: picture.id),
          CollectionUserPage(id: picture.id)
        ],
      ),
    );
  }
}
