import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/pages/picture/view.page.dart';
import 'package:zeongitbeautyflutter/pages/picture/widget/more_btn.widget.dart';
import 'package:zeongitbeautyflutter/pages/visitor/visitor_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/constant/status.constant.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/avatar.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/link.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/picture.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/shadow_icon.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/skeleton.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/text.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/title.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/btn/collect_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widget/btn/follow_btn.widget.dart';
import 'package:zeongitbeautyflutter/pages/search/search_result.page.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  PictureEntity picture;

  Future<ResultEntity<PictureEntity>> fetchData() async {
    return await PictureService.get(widget.id);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (BuildContext context,
            AsyncSnapshot<ResultEntity<PictureEntity>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var result = snapshot.data;
              if (result.status == StatusCode.SUCCESS) {
                picture = result.data;
                return buildMain(context);
              } else {
                //TODO
              }
            } else {
              return buildSkeleton(context);
            }
          }
          return buildSkeleton(context);
        });
  }

  Scaffold buildMain(BuildContext context) {
    var queryData = MediaQuery.of(context);
    var pageGap = StyleConfig.gap * 3;
    var userState = Provider.of<UserState>(context, listen: false);
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
            icon: ShadowIconWidget(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
          actions: picture.user.id == userState.info?.id
              ? [
                  IconButton(
                    icon: ShadowIconWidget(MdiIcons.image_edit_outline,
                        color: Colors.white),
                    onPressed: () => Navigator.maybePop(context),
                  )
                ]
              : [],
          elevation: 1,
          //默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
          floating: false,
          expandedHeight: queryData.size.width * picture.height / picture.width,
          //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
          flexibleSpace: FlexibleSpaceBar(
            background: buildMainPicture(),
            collapseMode: CollapseMode.pin,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(MdiIcons.message_outline),
                  onPressed: () {},
                ),
                CollectIconBtnWidget(
                    picture: picture,
                    callback: (picture, int focus) {
                      setState(() {
                        picture.focus = focus;
                      });
                    }),
                IconButton(
                  icon: Icon(MdiIcons.share_outline),
                  onPressed: () {},
                ),
                MoreBtn(
                  picture: picture,
                  callback: () {},
                )
              ],
            ),
            Divider(),
            Padding(
                padding: EdgeInsets.all(pageGap),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleWidget(picture.name),
                    TextWidget("创建于${picture.createDate}"),
                    Row(
                      children: <Widget>[
                        Row(children: <Widget>[
                          LinkWidget("${picture.viewAmount}"),
                          TextWidget("人阅读")
                        ]),
                        Padding(
                            padding: EdgeInsets.only(left: StyleConfig.gap * 3),
                            child: Row(children: <Widget>[
                              LinkWidget("${picture.likeAmount}"),
                              TextWidget("人喜欢")
                            ])),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: pageGap),
                      child: Html(data: picture.introduction),
                    )
                  ],
                )),
            Divider(),
            ...buildTagList(pageGap, context),
            Padding(
              padding: EdgeInsets.all(pageGap),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  buildAvatar(),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                      child: Text(picture.user.nickname),
                    ),
                  ),
                  FollowBtn(
                    user: picture.user,
                    callback: (user, int focus) {
                      setState(() {
                        picture.user.focus = focus;
                      });
                    },
                  )
                ],
              ),
            ),
          ]),
        )
      ],
    ));
  }

  Scaffold buildSkeleton(BuildContext context) {
    var queryData = MediaQuery.of(context);
    var pageGap = StyleConfig.gap * 3;
    return Scaffold(
        body:
//        Text("123")
        CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
            icon: ShadowIconWidget(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
          elevation: 1,
          //默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
          floating: false,
          expandedHeight: queryData.size.width,
          //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
          flexibleSpace: FlexibleSpaceBar(
            background: Skeleton(
              height: queryData.size.width,
              width: queryData.size.width,
            ),
            collapseMode: CollapseMode.pin,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
                padding: EdgeInsets.all(pageGap),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: pageGap / 2),
                      child: Skeleton(height: 16, width: 180),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: pageGap / 2),
                      child: Skeleton(height: 16, width: 300),
                    ),
                    Skeleton(height: 16, width: 250),
                  ],
                )),
            Divider(),
            Padding(
                padding: EdgeInsets.all(pageGap),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: pageGap / 2),
                      child: Skeleton(height: 16, width: 360),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: pageGap / 2),
                      child: Skeleton(height: 16, width: 270),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: pageGap / 2),
                      child: Skeleton(height: 16, width: 370),
                    ),
                    Skeleton(height: 16, width: 300),
                  ],
                )),
          ]),
        )
      ],
    )
        );
  }

  GestureDetector buildMainPicture() {
    GlobalKey<PictureWidgetState> pictureWidgetKey =
        GlobalKey<PictureWidgetState>();
    return GestureDetector(
      child: PictureWidget(picture.url,
          key: pictureWidgetKey,
          style: PictureStyle.specifiedHeight1200,
          fit: BoxFit.cover),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ViewPage(picture.url);
        }));
//        pictureWidgetKey.currentState.saveStorage();
      },
    );
  }

  InkWell buildAvatar() {
    var size = 75.0;
    var padding = 8.0;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: AvatarWidget(
          picture?.user?.avatarUrl,
          picture?.user?.nickname,
          size: size - padding * 2,
          fit: BoxFit.cover,
          style: AvatarStyle.small50,
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return VisitorTabPage(id: picture.user.id);
        }));
      },
    );
  }

  buildTagList(double pageGap, BuildContext context) {
    if (picture.tagList != null && picture.tagList.length > 0) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pageGap),
          child: Wrap(
              spacing: pageGap / 2,
              runSpacing: -pageGap / 2,
              children: picture.tagList
                      ?.map((e) => ActionChip(
                          label: Text(e),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return SearchResultPage(keyword: e);
                            }));
                          }))
                      ?.toList() ??
                  <Widget>[]),
        ),
        Divider()
      ];
    } else {
      return [];
    }
  }
}
