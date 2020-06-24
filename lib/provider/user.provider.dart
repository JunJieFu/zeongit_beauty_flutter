import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';

class UserState extends ChangeNotifier {
  UserInfoEntity _info;

  UserInfoEntity get info => _info;

  updateInfo(dynamic info) {
    _info = UserInfoEntity().fromJson(info);
    notifyListeners();
  }
}
