import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/provider/account.logic.dart';
import 'package:zeongitbeautyflutter/provider/user_info.logic.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

class FollowBtn extends StatelessWidget {
  FollowBtn({Key key, @required this.id, this.callback, this.small = false})
      : userInfoLogic =
            Get.find(tag: USER_INFO_LOGIC_TAG_PREFIX + id.toString()),
        super(key: key);
  final int id;

  final void Function(UserInfoEntity, int) callback;

  final bool small;

  final GlobalKey _btnKey = GlobalKey();

  final accountLogic = Get.find<AccountLogic>();

  final UserInfoLogic userInfoLogic;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
          key: _btnKey,
          style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
          child: Text(userInfoLogic.info.focus == FollowState.CONCERNED.index
              ? "已关注"
              : "关注"),
          onPressed: () async {
            if (accountLogic.info != null) {
              userInfoLogic.follow();
            } else {
              popupSignIn("想要关注这个画师？", "请先登录，然后才能成为该画师的粉丝。", context, _btnKey);
            }
          }),
    );
  }
}
