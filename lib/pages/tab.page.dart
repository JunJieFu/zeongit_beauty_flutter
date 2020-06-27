import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/pages/find.page.dart';
import 'package:zeongitbeautyflutter/pages/home.page.dart';
import 'package:zeongitbeautyflutter/widget/header.widget.dart';
import 'package:zeongitbeautyflutter/widget/menu.widget.dart';

class TabPage extends StatefulWidget {
  TabPage({Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  TabController _tabController;

  List<Tab> _tabList = [
    Tab(icon: Icon(Icons.home)),
    Tab(icon: Icon(Icons.find_in_page))
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
            children: <Widget>[HomePage(), FindPage()]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black12, width: .5)),
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: .1),
            ],
          ),
          child: TabBar(
            tabs: _tabList,
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
