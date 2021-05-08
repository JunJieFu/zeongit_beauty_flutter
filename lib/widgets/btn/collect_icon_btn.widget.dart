import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/provider/user.getx_ctrl.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

class CollectIconBtn extends HookWidget {
  CollectIconBtn({Key key, @required this.picture, @required this.callback})
      : super(key: key);
  final PictureEntity picture;

  final void Function(PictureEntity picture, int focus) callback;

  final _userGetxCtrl = Get.find<UserGetxCtrl>();

  @override
  Widget build(BuildContext context) {
    bool focus = picture.focus == CollectState.CONCERNED.index;
    final GlobalKey _btnKey = GlobalKey();
    final loading = useState(false);
    Future<void> onPressed() async {
      if (_userGetxCtrl.info != null) {
        if (loading.value) return;
        loading.value = true;
        var result = await CollectionService.focus(picture.id);
        loading.value = false;
        if (ResultUtil.check(result)) callback(picture, result.data);
      } else {
        popupSignIn("喜欢这张绘画？", "请先登录，然后才能把这张绘画添加到收藏夹。", context, _btnKey);
      }
    }

    return IconButton(
        key: _btnKey,
        icon: Icon(focus || loading.value ? Icons.star : Icons.star_border,
            color: loading.value
                ? StyleConfig.textColor
                : (focus ? StyleConfig.errorColor : null)),
        onPressed: onPressed);
  }
}
