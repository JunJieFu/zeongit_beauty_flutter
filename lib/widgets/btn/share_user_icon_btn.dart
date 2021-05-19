import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/plugins/constants/config.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/build.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/popup_container.widget.dart';

class ShareUserIconBtn extends StatelessWidget {
  ShareUserIconBtn({Key? key, required this.user, this.small = false})
      : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final UserInfoEntity user;

  final bool small;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: small
          ? StyleConfig.smallIconButtonSize
          : StyleConfig.defaultIconButtonSize,
      height: small
          ? StyleConfig.smallIconButtonSize
          : StyleConfig.defaultIconButtonSize,
      child: IconButton(
          key: _btnKey,
          iconSize:
              small ? StyleConfig.smallIconSize : StyleConfig.defaultIconSize,
          icon: Icon(MdiIcons.share_outline),
          onPressed: () {
            Navigator.push(
              context,
              PopupContainerRoute(
                child: PopupContainer(
                  targetRenderKey: _btnKey,
                  child: Card(
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                              title: buildListTileTitle("链接",
                                  leftIcon: MdiIcons.link),
                              onTap: () async {
                                Clipboard.setData(ClipboardData(
                                    text:
                                        '${ConfigConstant.BEAUTY_HOST}/user/${user.id}'));
                                BotToast.showText(text: "复制成功");
                                Get.back();
                              }),
                          Divider(height: 1),
                          ListTile(
                            title: buildListTileTitle("分享",
                                leftIcon: MdiIcons.share_variant),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
