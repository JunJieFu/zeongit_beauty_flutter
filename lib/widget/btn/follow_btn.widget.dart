import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/constant/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/popup.fun.dart';


class FollowBtn extends StatelessWidget {
  FollowBtn({Key key, @required this.user, @required this.callback})
      : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final UserInfoEntity user;

  final void Function(UserInfoEntity, int) callback;

  @override
  Widget build(BuildContext context) {
    var _userState = Provider.of<UserState>(context, listen: false);

    bool focus = user.focus == FollowState.CONCERNED.index;
    return RaisedButton(
        key: _btnKey,
        highlightElevation: 0,
        elevation: 0,
        textColor: Colors.white,
        color: StyleConfig.primaryColor,
        child: Text(focus ? "已关注" : "关注"),
        onPressed: () async {
          if (_userState.info != null) {
            var result = await FollowingService.follow(user.id);
            if (ResultUtil.check(result)) callback(user, result.data);
          } else {
            popupSignIn("想要关注这个画师？", "请先登录，然后才能成为该画师的粉丝。", context, _btnKey);
          }
        });
  }
}
