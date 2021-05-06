import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

class FollowBtn extends HookWidget {
  FollowBtn({Key key, @required this.user, @required this.callback})
      : super(key: key);

  final UserInfoEntity user;

  final void Function(UserInfoEntity, int) callback;

  @override
  Widget build(BuildContext context) {
    var userState = Provider.of<UserState>(context, listen: false);
    bool focus = user.focus == FollowState.CONCERNED.index;
    final GlobalKey _btnKey = GlobalKey();
    final loading = useState(false);
    Future<void> onPressed() async {
      if (userState.info != null) {
        if (loading.value) return;
        loading.value = true;
        var result = await FollowingService.follow(user.id);
        loading.value = false;
        if (ResultUtil.check(result)) callback(user, result.data);
      } else {
        popupSignIn("想要关注这个画师？", "请先登录，然后才能成为该画师的粉丝。", context, _btnKey);
      }
    }

    return ElevatedButton(
        key: _btnKey,
        style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
        child: Text(focus ? "已关注" : "关注"),
        onPressed: onPressed);
  }
}
