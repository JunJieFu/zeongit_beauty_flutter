import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/pages/search/search_picture.page.dart';
import 'package:zeongitbeautyflutter/pages/search/search_user.page.dart';

class SearchTabPage extends StatefulWidget {
  SearchTabPage({Key key, @required this.keyword}) : super(key: key);

  final String keyword;

  @override
  _SearchTabPageState createState() => _SearchTabPageState();
}

class _SearchTabPageState extends State<SearchTabPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this, //动画效果的异步处理，默认格式，背下来即可
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: _buildTabList(),
            controller: _tabController,
          ),
          elevation: 0,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SearchPicturePage(keyword: widget.keyword),
            SearchUserPage(keyword: widget.keyword)
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  _buildTabList() {
    return [Tab(text: "作品"), Tab(text: "用户")];
  }
}
