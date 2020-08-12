import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/detail.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/image_ink.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/picture.widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  bool loading = true;
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<PictureEntity> recommendList = [];
  List<PictureEntity> newList = [];

  Future<void> refresh() async {
    var result = await PictureService.pagingByRecommend(
        PageableEntity(page: 0, size: 10, sort: "createDate,desc"));
    var result2 = await PictureService.paging(
        PageableEntity(page: 0, size: 10, sort: "createDate,desc"));
    setState(() {
      recommendList.addAll(result.data.content);
      newList.addAll(result2.data.content);
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: refresh,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(title: Text("推荐作品")),
          buildPictureList(recommendList),
          ListTile(title: Text("最新作品")),
          buildPictureList(newList)
        ],
      ),
    );
  }

  buildPictureList(List<PictureEntity> list) {
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

  @override
  bool get wantKeepAlive => true;
}
