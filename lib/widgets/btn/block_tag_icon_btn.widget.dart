import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/provider/account.logic.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

class BlockTagIconBtn extends HookWidget {
  BlockTagIconBtn(
      {Key? key, required this.tag, required this.callback, this.small = false})
      : super(key: key);
  final TagBlackHoleEntity tag;

  final void Function(TagBlackHoleEntity, int) callback;

  final bool small;

  final _accountLogic = Get.find<AccountLogic>();

  final GlobalKey _btnKey = GlobalKey();

  final _loading = false.obs;

  Future<void> _onPressed() async {
    if (_accountLogic.info != null) {
      if (_loading.value) return;
      _loading.value = true;
      var result = await TagBlackHoleService.block(tag.name);
      _loading.value = false;
      if (ResultUtil.check(result)) callback(tag, result.data!);
    } else {
      popupSignIn("屏蔽该标签？", "请先登录，然后才能把屏蔽该标签。", Get.context!, _btnKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final normal = tag.state == BlockState.NORMAL.index;
    return SizedBox(
      width: small
          ? StyleConfig.smallIconButtonSize
          : StyleConfig.defaultIconButtonSize,
      height: small
          ? StyleConfig.smallIconButtonSize
          : StyleConfig.defaultIconButtonSize,
      child: IconButton(
          key: _btnKey,
          iconSize:
              small ? StyleConfig.smallIconSize : StyleConfig.defaultIconSize,
          icon: Icon(normal ? MdiIcons.eye_off_outline : MdiIcons.eye_outline),
          onPressed: _onPressed),
    );
  }
}
