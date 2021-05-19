import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/avatar.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/background.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/keep_alive_client.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/text.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/title.widget.dart';
import 'package:zeongitbeautyflutter/provider/user_info.logic.dart';
import 'package:zeongitbeautyflutter/widgets/btn/follow_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/btn/share_user_icon_btn.dart';

class UserDetailPage extends HookWidget {
  UserDetailPage({Key? key, required this.id})
      : logic = Get.find(tag: USER_INFO_LOGIC_TAG_PREFIX + id.toString()),
        super(key: key);

  final int id;

  final UserInfoLogic logic;

  @override
  Widget build(BuildContext context) {
    return KeepAliveClient(
      child: Obx(
        () => ListView(
          children: [
            Stack(children: <Widget>[
              AspectRatio(
                aspectRatio: 2,
                child: BackgroundWidget(
                  logic.info!.background,
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
              child:
                  Center(child: TitleWidget(logic.info!.nickname)),
            ),
            Padding(
              padding: EdgeInsets.only(top: StyleConfig.gap),
              child: Center(
                  child: TextWidget(logic.info!.introduction)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FollowIconBtn(
                    id: logic.info!.id),
                ShareUserIconBtn(
                  user: logic.info!
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildMaterialAvatar() {
    var size = 120.0;
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(size)),
      elevation: 3,
      child: AvatarWidget(logic.info!.avatarUrl, logic.info!.nickname,
          fit: BoxFit.cover, size: size),
    );
  }
}
