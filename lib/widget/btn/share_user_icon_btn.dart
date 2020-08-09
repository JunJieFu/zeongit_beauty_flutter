import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/provider/user.provider.dart';

import '../popup.fun.dart';

class ShareUserIconBtn extends StatelessWidget {
  ShareUserIconBtn({Key key, @required this.user, @required this.callback})
      : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final UserInfoEntity user;

  final Function callback;

  @override
  Widget build(BuildContext context) {
    var _userState = Provider.of<UserState>(context, listen: false);
    return IconButton(
        key: _btnKey,
        icon: Icon(Icons.share),
        onPressed: () async {
          popupSignIn("想要关注这个画师？", "请先登录，然后才能成为该画师的粉丝。", context, _btnKey);
        });
  }
}
