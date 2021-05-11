import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/pages/picture/edit.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/build.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/popup_container.widget.dart';
import 'package:zeongitbeautyflutter/provider/account.logic.dart';
import 'package:zeongitbeautyflutter/widgets/black_hole_dialog.widget.dart';
import 'package:zeongitbeautyflutter/widgets/complaint_dialog.widget.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

// 应该用状态管理才对
class MoreIconBtn extends StatelessWidget {
  MoreIconBtn(
      {Key key, @required this.picture, this.callback, this.small = false})
      : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final PictureEntity picture;

  final Function callback;

  final bool small;

  final _accountLogic = Get.find<AccountLogic>();

  _remove() {
    showDialog(
        context: Get.context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定删除该图片吗？"),
            actions: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(
                    primary: StyleConfig.warningColor,
                  ),
                  onPressed: Get.back,
                  child: Text("取消")),
              TextButton(
                  onPressed: () async {
                    Get.back();
//                    var result = await PictureService.remove(id);
//                    if (ResultUtil.check(result)) {
//                      Fluttertoast.showToast(
//                          msg: "删除成功",
//                          gravity: ToastGravity.BOTTOM,
//                          backgroundColor: StyleConfig.successColor);
//                    }
                    BotToast.showText(text: "网站作者不让删");
                  },
                  child: Text("确定"))
            ],
          );
        });
  }

  _hide() {
    final privacy = picture.privacy == PrivacyState.PRIVATE.index;
    showDialog(
        context: Get.context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定${privacy ? "公开" : "隐藏"}该图片吗？"),
            actions: <Widget>[
              TextButton(
                  style: TextButton.styleFrom(
                    primary: StyleConfig.warningColor,
                  ),
                  onPressed: Get.back,
                  child: Text("取消")),
              TextButton(
                  onPressed: () async {
                    Get.back();
                    BotToast.showText(text: "尚未开发");
                  },
                  child: Text("确定"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final privacy = picture.privacy == PrivacyState.PRIVATE.index;
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
                          children: _accountLogic.info.id == picture.user.id
                              ? [
                                  Divider(height: 1),
                                  ListTile(
                                    title: buildListTileTitle("编辑",
                                        leftIcon: MdiIcons.image_edit_outline),
                                    onTap: () {
                                      Get.to(EditPage(picture,
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
                                      _hide();
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
                                      _remove();
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
                                            context: Get.context,
                                            builder: (ctx) {
                                              return BlackHoleDialog(
                                                id: picture.id,
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
                                          context: Get.context,
                                          builder: (ctx) {
                                            return ComplaintDialog(
                                              picture: picture,
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
