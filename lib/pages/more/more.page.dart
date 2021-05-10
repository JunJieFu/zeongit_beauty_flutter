import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/pages/black_hole/black_hole_tab.page.dart';
import 'package:zeongitbeautyflutter/pages/fragment/about.page.dart';
import 'package:zeongitbeautyflutter/pages/fragment/feedback.page.dart';
import 'package:zeongitbeautyflutter/pages/palette.page.dart';
import 'package:zeongitbeautyflutter/pages/user/footprint.page.dart';
import 'package:zeongitbeautyflutter/pages/user/upload.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/build.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/avatar.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/background.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/text.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/title.widget.dart';
import 'package:zeongitbeautyflutter/provider/theme.logic.dart';
import 'package:zeongitbeautyflutter/provider/user.logic.dart';
import 'package:zeongitbeautyflutter/widgets/btn/share_user_icon_btn.dart';
import 'package:zeongitbeautyflutter/widgets/tips_page_card.widget.dart';

class MorePage extends StatelessWidget {
  MorePage({Key key}) : super(key: key);

  final _userLogic = Get.find<UserLogic>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_userLogic.info == null) {
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
                  _userLogic.info?.background,
                  fit: BoxFit.cover,
                  style: BackgroundStyle.backCard,
                ),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(top: StyleConfig.gap * 35),
                  child: _buildMaterialAvatar(),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.only(top: StyleConfig.gap * 3),
              child: Center(child: TitleWidget(_userLogic.info.nickname)),
            ),
            Padding(
              padding: EdgeInsets.only(top: StyleConfig.gap),
              child: Center(child: TextWidget(_userLogic.info.introduction)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ShareUserIconBtn(
                  user: _userLogic.info,
                  callback: () {},
                ),
              ],
            ),
            ..._buildListTile(MdiIcons.shoe_print, "足迹", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return FootprintPage(id: _userLogic.info.id);
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
            ..._buildListTile(MdiIcons.message_alert_outline, "反馈", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return FeedbackPage();
              }));
            }),
            ..._buildListTile(MdiIcons.palette, "调色板", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return PalettePage();
              }));
            }),
            ..._buildListTile(MdiIcons.information_outline, "关于", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return AboutPage();
              }));
            }),
            ..._buildListTile(MdiIcons.logout, "登出", () {
              _signOut();
            }),
            Divider(),
          ],
        );
      }
    });
  }

  _buildMaterialAvatar() {
    var size = 120.0;
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(size)),
      elevation: 3,
      child: AvatarWidget(
          _userLogic.info?.avatarUrl, _userLogic.info?.nickname,
          fit: BoxFit.cover, size: size),
    );
  }

  _buildListTile(IconData icon, String title, GestureTapCallback onTap) {
    return [
      Divider(height: 1),
      ListTile(
          onTap: onTap,
          title: buildListTileTitle(title,
              leftIcon: icon, rightIcon: Icons.keyboard_arrow_right))
    ];
  }

  _signOut() {
    showDialog(
        context: Get.context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定退出 Zeongit 账号吗？"),
            actions: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(
                    primary: StyleConfig.warningColor,
                  ),
                  onPressed:  Get.back,
                  child: Text("取消")),
              TextButton(
                  onPressed: () {
                    _userLogic.logout();
                    Get.back();
                  },
                  child: Text("确定"))
            ],
          );
        });
  }
}
