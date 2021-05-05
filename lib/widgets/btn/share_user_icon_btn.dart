import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';

class ShareUserIconBtn extends StatelessWidget {
  ShareUserIconBtn({Key key, @required this.user, @required this.callback})
      : super(key: key);
  final GlobalKey _btnKey = GlobalKey();

  final UserInfoEntity user;

  final Function callback;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        key: _btnKey, icon: Icon(MdiIcons.share_outline), onPressed: () async {});
  }
}
