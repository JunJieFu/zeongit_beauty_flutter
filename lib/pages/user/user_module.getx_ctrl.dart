import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';

const String TAG_PREFIX = "USER_MODULE";

class UserModuleGetxCtrl extends GetxController {
  final _info = Rx<UserInfoEntity>(null);

  UserInfoEntity get info => _info.value;

  setInfo(UserInfoEntity info) async {
    _info.value = info;
  }

  focus(int focus) {
    _info.update((val) {
      val.focus = focus;
    });
  }
}
