import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/provider/account.logic.dart';
import 'package:zeongitbeautyflutter/provider/picture.logic.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

class CollectIconBtn extends StatelessWidget {
  CollectIconBtn(
      {Key key, @required this.id, this.callback, this.small = false})
      : super(key: key);
  final int id;

  final void Function(PictureEntity picture, int focus) callback;

  final bool small;

  final GlobalKey _btnKey = GlobalKey();

  final accountLogic = Get.find<AccountLogic>();

  PictureLogic get pictureLogic =>
      Get.find(tag: PICTURE_LOGIC_TAG_PREFIX + id.toString());

  @override
  Widget build(BuildContext context) {
    final focus = pictureLogic.picture.focus == CollectState.CONCERNED.index;
    final loading = pictureLogic.loading;
    return SizedBox(
      width: small
          ? StyleConfig.smallIconButtonSize
          : StyleConfig.defaultIconButtonSize,
      height: small
          ? StyleConfig.smallIconButtonSize
          : StyleConfig.defaultIconButtonSize,
      child: Obx(
        () => IconButton(
            key: _btnKey,
            iconSize:
                small ? StyleConfig.smallIconSize : StyleConfig.defaultIconSize,
            icon: Icon(focus || loading.value ? Icons.star : Icons.star_border,
                color: loading.value
                    ? StyleConfig.textColor
                    : (focus ? StyleConfig.errorColor : null)),
            onPressed: () async {
              if (accountLogic.info != null) {
                await pictureLogic.collect();
              } else {
                popupSignIn(
                    "喜欢这张绘画？", "请先登录，然后才能把这张绘画添加到收藏夹。", Get.context, _btnKey);
              }
            }),
      ),
    );
  }
}
