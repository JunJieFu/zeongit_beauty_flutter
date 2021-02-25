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

class BlockTagIconBtnWidget extends StatelessWidget {
  BlockTagIconBtnWidget({Key key, @required this.tag, @required this.callback})
      : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final TagBlackHoleEntity tag;

  final Function callback;

  @override
  Widget build(BuildContext context) {
    var _userState = Provider.of<UserState>(context, listen: false);

    bool normal = tag.state == BlockState.NORMAL.index;

    return IconButton(
        key: _btnKey,
        icon: Icon(normal ? MdiIcons.eye_off_outline : MdiIcons.eye_outline),
        onPressed: () async {
          if (_userState.info != null) {
            var result = await TagBlackHoleService.block(tag.name);
            await ResultUtil.check(result);
            callback(tag, result.data);
          } else {
            popupSignIn("屏蔽该标签？", "请先登录，然后才能把屏蔽该标签。", context, _btnKey);
          }
        });
  }
}