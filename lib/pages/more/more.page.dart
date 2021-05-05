import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/black_hole_tab.page.dart';
import 'package:zeongitbeautyflutter/pages/fragment/about.page.dart';
import 'package:zeongitbeautyflutter/pages/user/footprint.page.dart';
import 'package:zeongitbeautyflutter/pages/user/upload.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/avatar.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/background.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/text.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/title.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widgets/btn/share_user_icon_btn.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class MorePage extends StatefulWidget {
  MorePage({Key key}) : super(key: key);

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage>
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
            icon: MdiIcons.dots_horizontal,
            title: "更多",
            text: "请先登录，才能获取更多操作。");
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
            ..._buildListTile(MdiIcons.shoe_print, "足迹", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return FootprintPage(id: userState.info.id);
              }));
            }),
            ..._buildListTile(MdiIcons.upload_outline, "上传", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return UploadPage();
              }));
            }),
            ..._buildListTile(MdiIcons.eye_off_outline, "屏蔽设置", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return BlackHoleTabPage();
              }));
            }),
            ..._buildListTile(MdiIcons.information_outline, "关于", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return AboutPage();
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
