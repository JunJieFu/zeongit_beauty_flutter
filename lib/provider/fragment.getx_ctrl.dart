import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';

class FragmentGetxCtrl extends GetxController {
  final _hasInit =
      (StorageManager.get<bool>(KeyConstant.HAD_INIT) ?? false).obs;

  bool get hasInit => _hasInit.value;

  updateHadInit() {
    StorageManager.setBool(KeyConstant.HAD_INIT, true);
    _hasInit.value = true;
  }
}
