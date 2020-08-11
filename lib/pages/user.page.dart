import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/pages/collection.page.dart';
import 'package:zeongitbeautyflutter/pages/follower.page.dart';
import 'package:zeongitbeautyflutter/pages/footprint.page.dart';
import 'package:zeongitbeautyflutter/pages/works.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/avatar.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/background.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/text.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/title.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/btn/follow_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widget/btn/share_user_icon_btn.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

import 'following.page.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<UserState>(builder: (ctx, UserState userState, child) {
      if (userState.info == null) {
        return _Unlisted();
      } else {
        return ListView(
          children: [
            Stack(children: <Widget>[
              AspectRatio(
                aspectRatio: 2,
                child: BackgroundWidget(
                  userState.info?.background,
                  fit: BoxFit.cover,
                  style: BackgroundStyle.backCard,
                ),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(top: StyleConfig.gap * 30),
                  child: AvatarWidget(userState.info,
                      fit: BoxFit.cover, size: 150),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.only(top: StyleConfig.gap * 3),
              child: Center(child: TitleWidget(userState.info.nickname)),
            ),
            Padding(
              padding: EdgeInsets.only(top: StyleConfig.gap),
              child: Center(child: TextWidget(userState.info.introduction)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FollowIconBtn(
                  user: userState.info,
                  callback: () {},
                ),
                ShareUserIconBtn(
                  user: userState.info,
                  callback: () {},
                ),
              ],
            ),
            ...buildListTile(Icons.star_border, "收藏", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return CollectionPage();
              }));
            }),
            ...buildListTile(MdiIcons.image_outline, "作品", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return WorksPage();
              }));
            }),
            ...buildListTile(MdiIcons.shoe_print, "足迹", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return FootprintPage();
              }));
            }),
            ...buildListTile(MdiIcons.account_heart_outline, "粉丝", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return FollowerPage();
              }));
            }),
            ...buildListTile(MdiIcons.account_star_outline, "关注", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return FollowingPage();
              }));
            }),
            ...buildListTile(MdiIcons.upload_outline, "上传", () {}),
            ...buildListTile(MdiIcons.cog_outline, "设置", () {}),
            ...buildListTile(MdiIcons.cog_outline, "退出", () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text("提示"),
                      content: Text("您确定退出 Zeongit 吗？"),
                      actions: <Widget>[
                        FlatButton(
                            textColor: StyleConfig.warningColor,
                            onPressed: () {
                              Navigator.of(context).pop(this);
                            },
                            child: Text("取消")),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop(this);
                            },
                            child: Text("确定"))
                      ],
                    );
                  });
            }),
            Divider(),
          ],
        );
      }
    });
  }

  List<Widget> buildListTile(
      IconData icon, String title, GestureTapCallback onTap) {
    return [
      Divider(height: 1),
      ListTile(
        onTap: onTap,
        title: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Icon(icon),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                child: Text(title),
              ),
            ),
            Icon(Icons.keyboard_arrow_right),
          ],
        ),
      )
    ];
  }
}

class _Unlisted extends StatelessWidget {
  _Unlisted({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInPageCardWidget(
        icon: MdiIcons.account_outline,
        title: "您的Zeongit Beauty主页",
        text: "请先登录，才能进入您的Zeongit Beauty主页。");
  }
}
