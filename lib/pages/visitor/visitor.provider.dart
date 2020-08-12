import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/service/index.dart';
import 'package:zeongitbeautyflutter/plugins/util/result.util.dart';

class VisitorState extends ChangeNotifier {
  VisitorState({UserInfoEntity info}) {
    this._info = info;
  }

  UserInfoEntity _info;

  UserInfoEntity get info => _info;

  getInfo(int id) async {
    var result = await UserService.getByTargetId(id);
    await ResultUtil.check(result);
    _info = result.data;
    notifyListeners();
  }

  focus(String focus) {
    info.focus = focus;
    notifyListeners();
  }
}
