import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/constant/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/util/string.util.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/popup.fun.dart';

class FollowIconBtn extends StatelessWidget {
  FollowIconBtn({Key key, @required this.user, @required this.callback})
      : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final UserInfoEntity user;

  final Function callback;

  @override
  Widget build(BuildContext context) {
    var _userState = Provider.of<UserState>(context, listen: false);

    bool focus = StringUtil.equalsEnum(user.focus, FollowState.CONCERNED);

    return IconButton(
        key: _btnKey,
        icon: Icon(focus ? Icons.star : Icons.star_border,
            color: focus ? StyleConfig.errorColor : null),
        onPressed: () async {
          if (_userState.info != null) {
            var result = await UserService.follow(user.id);
            await ResultUtil.check(result);
            callback(user, result.data);
          } else {
            popupSignIn("想要关注这个画师？", "请先登录，然后才能成为该画师的粉丝。", context, _btnKey);
          }
        });
  }
}
