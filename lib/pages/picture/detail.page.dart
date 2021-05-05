import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/mixins/future_builder_mixin.dart';
import 'package:zeongitbeautyflutter/pages/picture/edit.page.dart';
import 'package:zeongitbeautyflutter/pages/picture/view.page.dart';
import 'package:zeongitbeautyflutter/pages/search/search_tab.page.dart';
import 'package:zeongitbeautyflutter/pages/user/user_tab.page.dart';
import 'package:zeongitbeautyflutter/plugins/constants/status.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/avatar.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/link.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/picture.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/shadow_icon.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/skeleton.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/text.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/title.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widgets/btn/collect_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/follow_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/more_icon_btn.widget.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with FutureBuilderMixin<DetailPage, PictureEntity> {
  Future<ResultEntity<PictureEntity>> fetchData() async {
    await Future.delayed(Duration(milliseconds: 500));
    return await PictureService.get(widget.id);
  }

  @override
  void initState() {
    super.initState();
    try {
      FootprintService.save(widget.id);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return futureBuilder();
  }

  @override
  Widget buildMain(BuildContext context, ResultEntity<PictureEntity> result) {
    return _View(pictureResult: result);
  }

  @override
  Scaffold buildSkeleton(BuildContext context) {
    var queryData = MediaQuery.of(context);
    var pageGap = StyleConfig.gap * 3;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
            icon: ShadowIcon(Icons.arrow_back, color: Colors.white),
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
    ));
  }

  @override
  Widget buildError(BuildContext context) => buildSkeleton(context);
}

class _View extends StatefulWidget {
  _View({Key key, @required this.pictureResult}) : super(key: key);

  final ResultEntity<PictureEntity> pictureResult;

  @override
  _ViewState createState() => _ViewState(pictureResult);
}

class _ViewState extends State<_View> {
  //目的为了脱离上级参数，因为要做识图的更改
  _ViewState(this.pictureResult);

  final ResultEntity<PictureEntity> pictureResult;

  PictureEntity _picture;

  @override
  void initState() {
    super.initState();
    _picture = pictureResult.data;
  }

  @override
  Widget build(BuildContext context) {
    if (pictureResult.status == StatusCode.SUCCESS) {
      var queryData = MediaQuery.of(context);
      var pageGap = StyleConfig.gap * 3;
      var userState = Provider.of<UserState>(context, listen: false);
      return Scaffold(
          body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: ShadowIcon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            actions: _picture.user.id == userState.info?.id
                ? [
                    IconButton(
                      icon: ShadowIcon(MdiIcons.image_edit_outline,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return EditPage(_picture, callback: (picture) {});
                        }));
                      },
                    )
                  ]
                : [],
            elevation: 1,
            //默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
            floating: false,
            expandedHeight:
                queryData.size.width * _picture.height / _picture.width,
            //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
            flexibleSpace: FlexibleSpaceBar(
              background: _buildMainPicture(),
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
                  CollectIconBtn(
                      picture: _picture,
                      callback: (picture, int focus) {
                        setState(() {
                          picture.focus = focus;
                        });
                      }),
                  IconButton(
                    icon: Icon(MdiIcons.share_outline),
                    onPressed: () {},
                  ),
                  MoreIconBtn(
                    picture: _picture,
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
                      TitleWidget(_picture.name),
                      TextWidget("创建于${_picture.createDate}"),
                      Row(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Link("${_picture.viewAmount}"),
                            TextWidget("人阅读")
                          ]),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: StyleConfig.gap * 3),
                              child: Row(children: <Widget>[
                                Link("${_picture.likeAmount}"),
                                TextWidget("人喜欢")
                              ])),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: pageGap),
                        child: Html(data: _picture.introduction),
                      )
                    ],
                  )),
              Divider(),
              ..._buildTagList(pageGap, context),
              Padding(
                padding: EdgeInsets.all(pageGap),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    _buildAvatar(),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: StyleConfig.gap * 2),
                        child: Text(_picture.user.nickname),
                      ),
                    ),
                    FollowBtn(
                      user: _picture.user,
                      callback: (user, int focus) {
                        setState(() {
                          _picture.user.focus = focus;
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
    } else {
      return Container();
    }
  }

  GestureDetector _buildMainPicture() {
    return GestureDetector(
      child: PictureWidget(_picture.url,
          style: PictureStyle.specifiedHeight1200,
          fit: BoxFit.cover),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ViewPage(_picture.url);
        }));
      },
    );
  }

  InkWell _buildAvatar() {
    var size = 75.0;
    var padding = 8.0;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: AvatarWidget(
          _picture?.user?.avatarUrl,
          _picture?.user?.nickname,
          size: size - padding * 2,
          fit: BoxFit.cover,
          style: AvatarStyle.small50,
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return UserTabPage(id: _picture.user.id);
        }));
      },
    );
  }

  _buildTagList(double pageGap, BuildContext context) {
    if (_picture.tagList != null && _picture.tagList.length > 0) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pageGap),
          child: Wrap(
              spacing: pageGap / 2,
              runSpacing: -pageGap / 2,
              children: _picture.tagList
                      ?.map((e) => ActionChip(
                          label: Text(e),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return SearchTabPage(keyword: e);
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
