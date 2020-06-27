import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/pages/detail.page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  dynamic _loading = true;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey;
  PagePictureEntity _recommendList;
  PagePictureEntity _newList;

  Future<void> _listByRecommend() async {
    var result = await PictureService.pagingByRecommend(
        PageableEntity(page: 0, size: 10, sort: "createDate,desc"));
    var result2 = await PictureService.paging(
        PageableEntity(page: 0, size: 10, sort: "createDate,desc"));
    setState(() {
      _recommendList = result.data;
      _newList = result2.data;
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
    super.build(context);
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _listByRecommend,
      color: Colors.grey,
      backgroundColor: Colors.white,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(title: Text("推荐作品")),
          _PictureList(list: _recommendList?.content),
          ListTile(title: Text("最新作品")),
          _PictureList(list: _newList?.content)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _PictureList extends StatelessWidget {
  const _PictureList({Key key, @required this.list}) : super(key: key);

  final List<PictureEntity> list;

  @override
  Widget build(BuildContext context) {
    var gap = listGap;
    var gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //横轴元素个数
        mainAxisSpacing: gap, //纵轴间距
        crossAxisSpacing: gap, //横轴间距
        childAspectRatio: 1 //子组件宽高长度比例
        );

    return Padding(
      padding: EdgeInsets.fromLTRB(gap, 0, gap, gap),
      child: GridView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: gridDelegate,
          children: list?.map((PictureEntity e) {
                return InkWell(
                  child: Image.network(
                      "http://secdraimg.secdra.com/" +
                          e.url +
                          "-specifiedWidth",
                      fit: BoxFit.cover),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return DetailPage(id: e.id);
                    }));
                  },
                );
              })?.toList() ??
              <Widget>[]),
    );
  }
}
