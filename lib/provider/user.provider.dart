import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/assets/constant/key.constant.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/generated/json/user_info_entity_helper.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/util/storage.util.dart';

class UserState extends ChangeNotifier {
  UserState({UserInfoEntity info}) {
    this._info = info;
  }

  UserInfoEntity _info;

  UserInfoEntity get info => _info;

  getInfo() async {
    var result = await UserService.getInfo();
    await ResultUtil.check(result);
    StorageManager.setJson(
        KeyConstant.USER_INFO, userInfoEntityToJson(result.data));
    _info = result.data;
    notifyListeners();
  }

  logout() {
    StorageManager.remove(KeyConstant.USER_INFO);
    StorageManager.remove(KeyConstant.TOKEN_KEY);
    _info = null;
    notifyListeners();
  }
}
