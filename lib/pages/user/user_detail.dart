import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/pages/user/user_module.getx_ctrl.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/avatar.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/background.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/text.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/title.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/follow_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/share_user_icon_btn.dart';

class UserDetailPage extends HookWidget {
  UserDetailPage({Key key, @required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final _userModuleGetxCtrl =
        Get.find<UserModuleGetxCtrl>(tag: TAG_PREFIX + id.toString());
    return KeepAliveClient(
      child: Obx(
        () => ListView(
          children: [
            Stack(children: <Widget>[
              AspectRatio(
                aspectRatio: 2,
                child: BackgroundWidget(
                  _userModuleGetxCtrl.info?.background,
                  fit: BoxFit.cover,
                  style: BackgroundStyle.backCard,
                ),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(top: StyleConfig.gap * 35),
                  child: _buildMaterialAvatar(_userModuleGetxCtrl.info),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.only(top: StyleConfig.gap * 3),
              child:
                  Center(child: TitleWidget(_userModuleGetxCtrl.info.nickname)),
            ),
            Padding(
              padding: EdgeInsets.only(top: StyleConfig.gap),
              child: Center(
                  child: TextWidget(_userModuleGetxCtrl.info.introduction)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FollowIconBtn(
                    user: _userModuleGetxCtrl.info,
                    callback: (UserInfoEntity user, int focus) {
                      _userModuleGetxCtrl.focus(focus);
                    }),
                ShareUserIconBtn(
                  user: _userModuleGetxCtrl.info,
                  callback: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildMaterialAvatar(UserInfoEntity info) {
    var size = 120.0;
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(size)),
      elevation: 3,
      child: AvatarWidget(info?.avatarUrl, info?.nickname,
          fit: BoxFit.cover, size: size),
    );
  }
}
