import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/pages/picture/detail_user_tab.page.dart';
import 'package:zeongitbeautyflutter/pages/picture/view.page.dart';
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
import 'package:zeongitbeautyflutter/provider/fragment.logic.dart';
import 'package:zeongitbeautyflutter/provider/picture.logic.dart';
import 'package:zeongitbeautyflutter/provider/user_info.logic.dart';
import 'package:zeongitbeautyflutter/widgets/btn/collect_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/follow_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/more_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/share_picture_icon_btn.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

final pageGap = StyleConfig.gap * 3;

// ignore: must_be_immutable
class DetailPage extends HookWidget {
  DetailPage({Key key, @required this.id}) : super(key: key) {
    try {
      logic = Get.find(tag: PICTURE_LOGIC_TAG_PREFIX + id.toString());
    } catch (e) {
      logic = Get.put(PictureLogic(null),
          tag: PICTURE_LOGIC_TAG_PREFIX + id.toString());
    }
  }

  final int id;

  PictureLogic logic;

  final fragmentLogic = Get.find<FragmentLogic>();

  _buildLoading() {
    var pageGap = StyleConfig.gap * 3;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
            icon: ShadowIcon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 1,
          //默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
          floating: false,
          expandedHeight: Get.width,
          //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
          flexibleSpace: FlexibleSpaceBar(
            background: Skeleton(
              height: Get.width,
              width: Get.width,
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

  _buildError({String message}) => Scaffold(
      appBar: AppBar(title: Text("详情")),
      body: TipsPageCard(
          icon: MdiIcons.image_outline, title: "获取图片有误", text: message ?? ""));

  _buildMain() {
    return Scaffold(
        body: Obx(
      () => CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: ShadowIcon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
              },
            ),
            elevation: 1,
            //默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
            floating: false,
            expandedHeight:
                Get.width * logic.picture.height / logic.picture.width,
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
                    id: logic.picture.id,
                  ),
                  SharePictureIconBtn(id: logic.picture.id),
                  MoreIconBtn(id: logic.picture.id)
                ],
              ),
              Divider(),
              Padding(
                  padding: EdgeInsets.all(pageGap),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TitleWidget(logic.picture.name),
                      Row(
                        children: [
                          Row(
                            children: [
                              TextWidget("创建于："),
                              TextWidget(formatDate(
                                  DateTime.parse(logic.picture.createDate),
                                  [yyyy, '-', mm, '-', dd])),
                            ],
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: StyleConfig.gap * 6),
                              child: Row(children: <Widget>[
                                TextWidget("分辨率："),
                                TextWidget(
                                    "${logic.picture.width}×${logic.picture.height}")
                              ])),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Link(
                              "${logic.picture.viewAmount}",
                              onTap: () {
                                Get.to(DetailUserTabPage(
                                    picture: logic.picture, index: 0));
                              },
                            ),
                            TextWidget("人阅读")
                          ]),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: StyleConfig.gap * 3),
                              child: Row(children: <Widget>[
                                Link(
                                  "${logic.picture.likeAmount}",
                                  onTap: () {
                                    Get.to(DetailUserTabPage(
                                        picture: logic.picture, index: 1));
                                  },
                                ),
                                TextWidget("人喜欢")
                              ])),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: pageGap),
                        child: Html(data: logic.picture.introduction),
                      )
                    ],
                  )),
              Divider(),
              ..._buildTagList(pageGap),
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
                        child: Text(logic.picture.user.nickname),
                      ),
                    ),
                    Builder(builder: (context) {
                      try {
                        Get.find(
                            tag: USER_INFO_LOGIC_TAG_PREFIX +
                                logic.picture.user.id.toString());
                      } catch (e) {
                        Get.put(UserInfoLogic(logic.picture.user),
                            tag: USER_INFO_LOGIC_TAG_PREFIX +
                                logic.picture.user.id.toString());
                      }
                      return FollowBtn(
                        id: logic.picture.user.id,
                      );
                    })
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    ));
  }

  _buildMainPicture() {
    return GestureDetector(
      child: PictureWidget(logic.picture.url,
          style: PictureStyle.specifiedHeight1200, fit: BoxFit.cover),
      onTap: () {
        Get.to(ViewPage(logic.picture.url));
      },
    );
  }

  _buildAvatar() {
    var size = 75.0;
    var padding = 8.0;
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: AvatarWidget(
          logic.picture?.user?.avatarUrl,
          logic.picture?.user?.nickname,
          size: size - padding * 2,
          fit: BoxFit.cover,
          style: AvatarStyle.small50,
        ),
      ),
      onTap: () {
        Get.to(UserTabPage(id: logic.picture.user.id));
      },
    );
  }

  _buildTagList(double pageGap) {
    if (logic.picture.tagList != null && logic.picture.tagList.length > 0) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pageGap),
          child: Wrap(
              spacing: pageGap / 2,
              runSpacing: -pageGap / 2,
              children: logic.picture.tagList
                      ?.map((e) => ActionChip(
                          label: Text(e),
                          onPressed: () {
                            fragmentLogic.searchPicture(e);
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

  @override
  Widget build(BuildContext context) {
    Widget widget = _buildLoading();
    //如果不为空，则不用向api获取
    if (logic.picture?.width != null && logic.picture?.height != null) {
      return _buildMain();
    }

    var snapshot = useFuture<ResultEntity<PictureEntity>>(useMemoized(() async {
      await Future.delayed(Duration(milliseconds: 500));
      return await PictureService.get(id);
    }), initialData: null);
    if (snapshot.hasData) {
      final result = snapshot.data;
      if (result.status == StatusCode.SUCCESS) {
        logic.set(result.data);
        widget = _buildMain();
      } else {
        widget = _buildError(message: result.message);
      }
    } else {
      widget = _buildLoading();
    }
    return widget;
  }
}
