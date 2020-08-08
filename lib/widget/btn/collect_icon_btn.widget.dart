import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';

import '../popup.fun.dart';

class CollectIconWidget extends StatelessWidget {
  CollectIconWidget({Key key,@required this.picture, @required this.callback}) : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final PictureEntity picture;

  final Function callback;

  @override
  Widget build(BuildContext context) {
    var _userState = Provider.of<UserState>(context, listen: false);

    return IconButton(
        key: _btnKey,
        icon: Icon(Icons.star_border),
        onPressed: () async {
          if (_userState.info != null) {
            var result = await CollectionService.focus(picture.id);
            //TODO 处理异常
            callback(picture, result.data);
          } else {
            popupSignIn("喜欢这张绘画？", "请先登录，然后才能把这张绘画添加到收藏夹。", context, _btnKey);
          }
        }
    );
  }
}