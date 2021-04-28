import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/abstract/refresh.abstract.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/picture/detail.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/image_ink.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/picture.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends RefreshAbstract<HomePage>
    with AutomaticKeepAliveClientMixin {
  bool loading = true;
  @override
  ScrollController scrollController = ScrollController();
  List<PictureEntity> followingPictureList = [];
  List<PictureEntity> recommendList = [];
  List<PictureEntity> newList = [];
  UserInfoEntity info;
  PageableEntity pageable = PageableEntity(limit: 10);

  Future<void> refresh() async {
    var result = await PictureService.pagingByRecommend(pageable);
    var result2 = await PictureService.paging(pageable);
    ResultEntity<PagePictureEntity> result3;
    if (info != null) {
      result3 = await PictureService.pagingByFollowing(pageable);
    }
    setState(() {
      recommendList = result.data.items;
      newList = result2.data.items;
      followingPictureList = result3?.data?.items ?? [];
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
    return Consumer<UserState>(builder: (ctx, UserState userState, child) {
      info = userState.info;
      return RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: refresh,
        child: ListView(
          controller: scrollController,
          shrinkWrap: true,
          children: <Widget>[
            ...() {
              return followingPictureList.isEmpty
                  ? []
                  : [
                      ListTile(title: Text("已关注用户的作品")),
                      buildPictureList(followingPictureList)
                    ];
            }(),
            ...() {
              return recommendList.isEmpty
                  ? []
                  : [
                      ListTile(title: Text("推荐作品")),
                      buildPictureList(recommendList)
                    ];
            }(),
            ...() {
              return newList.isEmpty
                  ? []
                  : [ListTile(title: Text("最新作品")), buildPictureList(newList)];
            }(),
          ],
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;

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
                    borderRadius: BorderRadius.all(
                        Radius.circular(StyleConfig.pictureRadius)),
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
