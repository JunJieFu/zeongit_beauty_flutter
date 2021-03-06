import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/provider/account.logic.dart';
import 'package:zeongitbeautyflutter/provider/user_info.logic.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

class FollowIconBtn extends StatelessWidget {
  FollowIconBtn({Key? key, required this.id, this.callback, this.small = false})
      : _userInfoLogic =
            Get.find(tag: USER_INFO_LOGIC_TAG_PREFIX + id.toString()),
        super(key: key);
  final int id;

  final void Function(UserInfoEntity, int)? callback;

  final bool small;

  final GlobalKey _btnKey = GlobalKey();

  final _accountLogic = Get.find<AccountLogic>();

  final UserInfoLogic _userInfoLogic;

  @override
  Widget build(BuildContext context) {
    final focus = _userInfoLogic.info!.focus == FollowState.CONCERNED.index;
    final loading = _userInfoLogic.loading;
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
              if (_accountLogic.info != null) {
                _userInfoLogic.follow();
              } else {
                popupSignIn(
                    "想要关注这个画师？", "请先登录，然后才能成为该画师的粉丝。", context, _btnKey);
              }
            }),
      ),
    );
  }
}
