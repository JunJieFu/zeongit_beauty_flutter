import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/assets/style/index.style.dart';
import 'package:zeongitbeautyflutter/pages/detail.page.dart';
import 'package:zeongitbeautyflutter/widget/fragment/image_ink.widget.dart';
import 'package:zeongitbeautyflutter/widget/fragment/picture.widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  bool _loading = true;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<PictureEntity> _recommendList = [];
  List<PictureEntity> _newList = [];

  Future<void> _refresh() async {
    var result = await PictureService.pagingByRecommend(
        PageableEntity(page: 0, size: 10, sort: "createDate,desc"));
    var result2 = await PictureService.paging(
        PageableEntity(page: 0, size: 10, sort: "createDate,desc"));
    setState(() {
      _recommendList.addAll(result.data.content);
      _newList.addAll(result2.data.content);
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(title: Text("推荐作品")),
          _PictureList(list: _recommendList),
          ListTile(title: Text("最新作品")),
          _PictureList(list: _newList)
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
    var gap = StyleConfig.listGap;
    var gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //横轴元素个数
        mainAxisSpacing: gap, //纵轴间距
        crossAxisSpacing: gap, //横轴间距
        childAspectRatio: 1 //子组件宽高长度比例
        );

    return Padding(
      padding: EdgeInsets.fromLTRB(gap, 0, gap, gap),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: gridDelegate,
          itemCount: list?.length,
          itemBuilder: (BuildContext context, int index) {
            var picture = list[index];
            return ImageInkWidget(
                constrained: true,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(gap)),
                    child: PictureWidget(
                      picture.url,
                      style: PictureStyle.specifiedWidth,
                      fit: BoxFit.cover,
                    )),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DetailPage(id: picture.id);
                  }));
                });
          }),
    );
  }
}
