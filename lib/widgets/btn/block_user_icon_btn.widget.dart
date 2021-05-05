import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

class BlockUserIconBtn extends HookWidget {
  BlockUserIconBtn({Key key, @required this.user, @required this.callback})
      : super(key: key);
  final UserBlackHoleEntity user;

  final void Function(UserBlackHoleEntity, int) callback;

  @override
  Widget build(BuildContext context) {
    var userState = Provider.of<UserState>(context, listen: false);
    bool normal = user.state == BlockState.NORMAL.index;
    final GlobalKey _btnKey = GlobalKey();
    final loading = useState(false);
    Future<void> onPressed() async {
      if (userState.info != null) {
        if (loading.value) return;
        loading.value = true;
        var result = await UserBlackHoleService.block(user.id);
        loading.value = false;
        if (ResultUtil.check(result)) callback(user, result.data);
      } else {
        popupSignIn("屏蔽该用户？", "请先登录，然后才能把屏蔽该用户。", context, _btnKey);
      }
    }

    return IconButton(
        key: _btnKey,
        icon: Icon(normal ? MdiIcons.eye_off_outline : MdiIcons.eye_outline),
        onPressed: onPressed);
  }
}
