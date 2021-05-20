import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/pages/picture/edit.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/build.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/popup_container.widget.dart';
import 'package:zeongitbeautyflutter/provider/account.logic.dart';
import 'package:zeongitbeautyflutter/provider/picture.logic.dart';
import 'package:zeongitbeautyflutter/widgets/black_hole_dialog.widget.dart';
import 'package:zeongitbeautyflutter/widgets/complaint_dialog.widget.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

class MoreIconBtn extends StatelessWidget {
  MoreIconBtn({Key? key, required this.id, this.small = false})
      : logic = Get.find(tag: PICTURE_LOGIC_TAG_PREFIX + id.toString()),
        super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final int id;

  final bool small;

  final PictureLogic logic;

  final _accountLogic = Get.find<AccountLogic>();

  @override
  Widget build(BuildContext context) {
    final privacy = logic.picture!.privacy == PrivacyState.PRIVATE.index;
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
        icon: Icon(Icons.more_vert),
        onPressed: () {
          if (_accountLogic.info != null) {
            Navigator.push(
              context,
              PopupContainerRoute(
                child: PopupContainer(
                  targetRenderKey: _btnKey,
                  child: Card(
                    child: Container(
                      width: 150,
                      child: Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: _accountLogic.info?.id ==
                                  logic.picture!.user.id
                              ? [
                                  Divider(height: 1),
                                  ListTile(
                                    title: buildListTileTitle("编辑",
                                        leftIcon: MdiIcons.image_edit_outline),
                                    onTap: () {
                                      Get.to(() => EditPage(logic.picture!,
                                          callback: (picture) {}));
                                    },
                                  ),
                                  Divider(height: 1),
                                  ListTile(
                                    title: buildListTileTitle(
                                        privacy ? "公开" : "隐藏",
                                        leftIcon: privacy
                                            ? MdiIcons.eye_outline
                                            : MdiIcons.eye_off_outline),
                                    onTap: () {
                                      Get.back();
                                      logic.hide();
                                    },
                                  ),
                                  Divider(height: 1),
                                  ListTile(
                                    title: buildListTileTitle("删除",
                                        leftIcon: privacy
                                            ? MdiIcons.eye_off_outline
                                            : MdiIcons.delete_outline),
                                    onTap: () {
                                      Get.back();
                                      logic.remove();
                                    },
                                  )
                                ]
                              : [
                                  ListTile(
                                      title: buildListTileTitle("屏蔽",
                                          leftIcon:
                                              MdiIcons.shield_off_outline),
                                      onTap: () {
                                        Get.back();
                                        showDialog(
                                            context: Get.context!,
                                            builder: (ctx) {
                                              return BlackHoleDialog(
                                                id: logic.picture!.id,
                                              );
                                            });
                                      }),
                                  Divider(height: 1),
                                  ListTile(
                                    title: buildListTileTitle("举报",
                                        leftIcon:
                                            MdiIcons.alert_octagon_outline),
                                    onTap: () {
                                      Get.back();
                                      showDialog(
                                          context: Get.context!,
                                          builder: (ctx) {
                                            return ComplaintDialog(
                                              id: logic.picture!.id,
                                            );
                                          });
                                    },
                                  )
                                ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            popupSignIn("想要关于绘画的更多操作？", "请先登录，然后才能获取更多绘画操作。", context, _btnKey);
          }
        },
      ),
    );
  }
}
