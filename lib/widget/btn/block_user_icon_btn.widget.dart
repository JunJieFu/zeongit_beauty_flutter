import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/constant/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/style/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widget/popup.fun.dart';

class BlockUserIconBtnWidget extends StatelessWidget {
  BlockUserIconBtnWidget(
      {Key key, @required this.user, @required this.callback})
      : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final UserBlackHoleEntity user;

  final void Function(UserBlackHoleEntity, int) callback;

  @override
  Widget build(BuildContext context) {
    var userState = Provider.of<UserState>(context, listen: false);

    bool normal = user.state == BlockState.NORMAL.index;

    return IconButton(
        key: _btnKey,
        icon: Icon(normal ? MdiIcons.eye_off_outline : MdiIcons.eye_outline),
        onPressed: () async {
          if (userState.info != null) {
            var result = await UserBlackHoleService.block(user.id);
            if (ResultUtil.check(result)) callback(user, result.data);
          } else {
            popupSignIn("屏蔽该用户？", "请先登录，然后才能把屏蔽该用户。", context, _btnKey);
          }
        });
  }
}
