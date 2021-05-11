import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/services/index.dart';
import 'package:zeongitbeautyflutter/plugins/utils/result.util.dart';

const String USER_INFO_LOGIC_TAG_PREFIX = "USER_INFO_LOGIC:";

class UserInfoLogic extends GetxController {
  UserInfoLogic(this.initial);

  final UserInfoEntity initial;

  final Rx<UserInfoEntity> _info = Rx<UserInfoEntity>(null);

  UserInfoEntity get info => _info.value;

  final loading = false.obs;

  set(UserInfoEntity p) async {
    _info.value = p;
  }

  follow(int focus) async {
    if (loading.value) return;
    loading.value = true;
    var result = await FollowingService.follow(info.id);
    loading.value = false;
    if(ResultUtil.check(result)){
      _info.update((val) {
        val.focus = result.data;
      });
    }
  }

  @override
  onInit() {
    super.onInit();
    _info.value = initial;
  }
}
