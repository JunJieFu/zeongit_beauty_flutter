import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/generated/json/user_info_entity_helper.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';

class AccountLogic extends GetxController {
  final _info = Rx<UserInfoEntity>(
      StorageManager.getJson(KeyConstant.USER_INFO) != null
          ? userInfoEntityFromJson(
              UserInfoEntity(), StorageManager.getJson(KeyConstant.USER_INFO))
          : null);

  UserInfoEntity get info => _info.value;

  getInfo() async {
    var result = await UserInfoService.get();
    if (ResultUtil.check(result)) {
      StorageManager.setJson(
          KeyConstant.USER_INFO, userInfoEntityToJson(result.data));
      _info.value = result.data;
    }
  }

  logout() {
    StorageManager.remove(KeyConstant.USER_INFO);
    StorageManager.remove(KeyConstant.TOKEN_KEY);
    _info.value = null;
  }
}
