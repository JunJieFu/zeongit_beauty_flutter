import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';

class VisitorState extends ChangeNotifier {
  VisitorState({UserInfoEntity info}) {
    this._info = info;
  }

  UserInfoEntity _info;

  UserInfoEntity get info => _info;

  setInfo(UserInfoEntity info) async {
    _info = info;
    notifyListeners();
  }

  focus(String focus) {
    info.focus = focus;
    notifyListeners();
  }
}
