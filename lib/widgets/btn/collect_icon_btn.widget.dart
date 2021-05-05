import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/constants/enum.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';
import 'package:zeongitbeautyflutter/widgets/popup.fun.dart';

class CollectIconBtn extends StatelessWidget {
  CollectIconBtn(
      {Key key, @required this.picture, @required this.callback})
      : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final PictureEntity picture;

  final void Function(PictureEntity picture, int focus) callback;

  @override
  Widget build(BuildContext context) {
    var userState = Provider.of<UserState>(context, listen: false);

    bool focus = picture.focus == CollectState.CONCERNED.index;

    return IconButton(
        key: _btnKey,
        icon: Icon(focus ? Icons.star : Icons.star_border,
            color: focus ? StyleConfig.errorColor : null),
        onPressed: () async {
          if (userState.info != null) {
            var result = await CollectionService.focus(picture.id);
            if (ResultUtil.check(result)) callback(picture, result.data);
          } else {
            popupSignIn("喜欢这张绘画？", "请先登录，然后才能把这张绘画添加到收藏夹。", context, _btnKey);
          }
        });
  }
}