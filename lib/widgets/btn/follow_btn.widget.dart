import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/provider/account.logic.dart';
import 'package:zeongitbeautyflutter/widgets/btn/follow_icon_btn.widget.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

class FollowBtn extends StatelessWidget {
  FollowBtn({Key key, @required this.id, this.callback, this.small = false})
      : logic = FollowBtnLogic(id),
        super(key: key);
  final int id;

  final void Function(UserInfoEntity, int) callback;

  final bool small;

  final FollowBtnLogic logic;

  final GlobalKey _btnKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
          key: _btnKey,
          style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
          child: Text(logic.userInfoLogic.info.focus == FollowState.CONCERNED.index ? "已关注" : "关注"),
          onPressed: () async {
            if (logic.accountLogic.info != null) {
              logic.userInfoLogic.follow();
            } else {
              popupSignIn("想要关注这个画师？", "请先登录，然后才能成为该画师的粉丝。", context, _btnKey);
            }
          }),
    );
  }
}
