import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/pages/picture/edit.page.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/build.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/popup_container.widget.dart';
import 'package:zeongitbeautyflutter/provider/user.getx_ctrl.dart';
import 'package:zeongitbeautyflutter/widgets/black_hole_dialog.widget.dart';
import 'package:zeongitbeautyflutter/widgets/complaint_dialog.widget.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

// 应该用状态管理才对
class MoreIconBtn extends StatelessWidget {
  MoreIconBtn({Key key, @required this.picture, this.callback})
      : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final PictureEntity picture;

  final Function callback;

  final _userGetxCtrl = Get.find<UserGetxCtrl>();

  _remove(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定删除该图片吗？"),
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
                  onPressed: () async {
                    Navigator.of(context).pop(this);
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

  _hide(BuildContext context) {
    final privacy = picture.privacy == PrivacyState.PRIVATE.index;
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定${privacy ? "公开" : "隐藏"}该图片吗？"),
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
                  onPressed: () async {
                    Navigator.of(context).pop(this);
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
    return IconButton(
      key: _btnKey,
      icon: Icon(Icons.more_vert),
      onPressed: () {
        if (_userGetxCtrl.info != null) {
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
                        children: _userGetxCtrl.info.id == picture.user.id
                            ? [
                                Divider(height: 1),
                                ListTile(
                                  title: buildListTileTitle("编辑",
                                      leftIcon: MdiIcons.image_edit_outline),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return EditPage(picture,
                                          callback: (picture) {});
                                    }));
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
                                    Navigator.of(context).pop(this);
                                    _hide(context);
                                  },
                                ),
                                Divider(height: 1),
                                ListTile(
                                  title: buildListTileTitle("删除",
                                      leftIcon: privacy
                                          ? MdiIcons.eye_off_outline
                                          : MdiIcons.delete_outline),
                                  onTap: () {
                                    Navigator.of(context).pop(this);
                                    _remove(context);
                                  },
                                )
                              ]
                            : [
                                ListTile(
                                    title: buildListTileTitle("屏蔽",
                                        leftIcon: MdiIcons.shield_off_outline),
                                    onTap: () {
                                      Navigator.of(context).pop(this);
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return BlackHoleDialog(
                                              id: picture.id,
                                            );
                                          });
                                    }),
                                Divider(height: 1),
                                ListTile(
                                  title: buildListTileTitle("举报",
                                      leftIcon: MdiIcons.alert_octagon_outline),
                                  onTap: () {
                                    Navigator.of(context).pop(this);
                                    showDialog(
                                        context: context,
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
    );
  }
}
