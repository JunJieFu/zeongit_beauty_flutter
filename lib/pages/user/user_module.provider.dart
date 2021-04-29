import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';

class UserModuleState extends ChangeNotifier {
  UserModuleState({UserInfoEntity info}) {
    this._info = info;
  }

  UserInfoEntity _info;

  UserInfoEntity get info => _info;

  setInfo(UserInfoEntity info) async {
    _info = info;
    notifyListeners();
  }

  focus(int focus) {
    info.focus = focus;
    notifyListeners();
  }
}
