import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';
import 'package:zeongitbeautyflutter/widget/menu.widget.dart';
import 'package:zeongitbeautyflutter/widget/header.widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;
  List<PictureEntity> _recommendList;
  List<PictureEntity> _newList;

  Future<void> _listByRecommend() async {
    var result = await PictureService.pagingByRecommend(
        PageableEntity(page: 0, size: 10, sort: "createDate,desc"));
    var result2 = await PictureService.paging(
        PageableEntity(page: 0, size: 10, sort: "createDate,desc"));
    setState(() {
      var page = JsonConvert.fromJsonAsT<PageEntity>(result.data);
      _recommendList =
          JsonConvert.fromJsonAsT<List<PictureEntity>>(page.content);
      var page2 = JsonConvert.fromJsonAsT<PageEntity>(result2.data);
      _newList =
          JsonConvert.fromJsonAsT<List<PictureEntity>>(page2.content);
      _loading = false;
    });
    return;
  }

  @override
  void initState() {
    super.initState();
    _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderWidget(),
        drawer: Drawer(
          //New added
          child: MenuWidget(), //New added
        ), //New added
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _listByRecommend,
          color: Colors.grey,
          backgroundColor: Colors.white,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //横轴元素个数
                        crossAxisCount: 2,
                        //纵轴间距
                        mainAxisSpacing: 10.0,
                        //横轴间距
                        crossAxisSpacing: 10.0,
                        //子组件宽高长度比例
                        childAspectRatio: 1),
                    children: _recommendList?.map((PictureEntity e) {
                          return Image.network(
                              "http://secdraimg.secdra.com/" +
                                  e.url +
                                  "-specifiedWidth",
                              fit: BoxFit.cover);
                        })?.toList() ??
                        <Widget>[]),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //横轴元素个数
                        crossAxisCount: 2,
                        //纵轴间距
                        mainAxisSpacing: 10.0,
                        //横轴间距
                        crossAxisSpacing: 10.0,
                        //子组件宽高长度比例
                        childAspectRatio: 1),
                    children: _newList?.map((PictureEntity e) {
                          return Image.network(
                              "http://secdraimg.secdra.com/" +
                                  e.url +
                                  "-specifiedWidth",
                              fit: BoxFit.cover);
                        })?.toList() ??
                        <Widget>[]),
              )
            ],
          ),
        ));
  }
}
