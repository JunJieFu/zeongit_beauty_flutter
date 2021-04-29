import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/pages/footprint.page.dart';
import 'package:zeongitbeautyflutter/pages/setting.page.dart';
import 'package:zeongitbeautyflutter/pages/user/collection.page.dart';
import 'package:zeongitbeautyflutter/pages/user/follower.page.dart';
import 'package:zeongitbeautyflutter/pages/user/following.page.dart';
import 'package:zeongitbeautyflutter/pages/user/following_new.page.dart';
import 'package:zeongitbeautyflutter/pages/user/works.page.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widget/avatar.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/background.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/text.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/title.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/btn/share_user_icon_btn.dart';
import 'package:zeongitbeautyflutter/widget/tips_page_card.widget.dart';

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
        return SignInPageCardWidget(
            icon: MdiIcons.account_outline,
            title: "您的Zeongit Beauty主页",
            text: "请先登录，才能进入您的Zeongit Beauty主页。");
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
                  padding: EdgeInsets.only(top: StyleConfig.gap * 35),
                  child: _buildMaterialAvatar(userState),
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
                ShareUserIconBtn(
                  user: userState.info,
                  callback: () {},
                ),
              ],
            ),
            ..._buildListTile(MdiIcons.account_multiple_outline, "关注最新", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return FollowingNewPage();
              }));
            }),
            ..._buildListTile(Icons.star_border, "收藏", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return CollectionPage(id: userState.info.id);
              }));
            }),
            ..._buildListTile(MdiIcons.image_outline, "作品", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return WorksPage(id: userState.info.id);
              }));
            }),
            ..._buildListTile(MdiIcons.shoe_print, "足迹", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return FootprintPage(id: userState.info.id);
              }));
            }),
            ..._buildListTile(MdiIcons.account_heart_outline, "粉丝", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return FollowerPage(id: userState.info.id);
              }));
            }),
            ..._buildListTile(MdiIcons.account_star_outline, "关注", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return FollowingPage(id: userState.info.id);
              }));
            }),
            ..._buildListTile(MdiIcons.upload_outline, "上传", () {}),
            ..._buildListTile(MdiIcons.cog_outline, "设置", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return SettingPage();
              }));
            }),
            ..._buildListTile(MdiIcons.logout, "登出", () {
              _signOut(userState);
            }),
            Divider(),
          ],
        );
      }
    });
  }

  _buildMaterialAvatar(UserState userState) {
    var size = 120.0;
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(size)),
      elevation: 3,
      child: AvatarWidget(userState.info?.avatarUrl, userState.info?.nickname,
          fit: BoxFit.cover, size: size),
    );
  }

  _buildListTile(IconData icon, String title, GestureTapCallback onTap) {
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

  _signOut(userState) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定退出 Zeongit 吗？"),
            actions: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(
                    primary: StyleConfig.warningColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(this);
                  },
                  child: Text("取消")),
              TextButton(
                  onPressed: () {
                    userState.logout();
                    Navigator.of(context).pop(this);
                  },
                  child: Text("确定"))
            ],
          );
        });
  }
}
