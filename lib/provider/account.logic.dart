import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/generated/json/user_info_entity_helper.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/comfir.widget.dart';

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

  signOut() {
    showDialog(
        context: Get.context,
        builder: (ctx) {
          return Confirm(
            title: Text("提示"),
            content: Text("您确定退出 Zeongit 账号吗？"),
            cancelText: Text("取消"),
            confirmText: Text("确定"),
            confirmCallback: () async {
              Get.back();
              StorageManager.remove(KeyConstant.USER_INFO);
              StorageManager.remove(KeyConstant.TOKEN_KEY);
              _info.value = null;
            },
          );
        });
  }
}
