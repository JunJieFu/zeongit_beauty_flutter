import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zeongitbeautyflutter/pages/search/search_picture.page.dart';
import 'package:zeongitbeautyflutter/pages/search/search_user.page.dart';

class SearchTabPage extends HookWidget {
  SearchTabPage({Key? key, required this.keyword, this.index = 0})
      : super(key: key);

  final String keyword;

  final int index;

  final _tabList = [Tab(text: "作品"), Tab(text: "用户")];

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
          ),
          elevation: 0,
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            SearchPicturePage(keyword: keyword),
            SearchUserPage(keyword: keyword)
          ],
        ));
  }
}
