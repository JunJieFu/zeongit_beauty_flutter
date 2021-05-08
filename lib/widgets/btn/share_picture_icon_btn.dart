import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/plugins/constants/config.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/build.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/popup_container.widget.dart';

class SharePictureIconBtn extends StatelessWidget {
  SharePictureIconBtn({Key key, @required this.picture, this.callback})
      : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final PictureEntity picture;

  final Function callback;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        key: _btnKey,
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
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                  text:
                                      '${ConfigConstant.BEAUTY_HOST}/picture/${picture.id}'));
                              BotToast.showText(text: "复制成功");
                              Navigator.of(context).pop(this);
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
        });
  }
}
