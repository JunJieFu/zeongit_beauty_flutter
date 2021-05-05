import 'package:fluttertoast/fluttertoast.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/plugins/constants/status.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';

class ResultUtil {
  static bool check(ResultEntity result) {
    if (result.status != StatusCode.SUCCESS) {
      Fluttertoast.showToast(
          msg: result.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: StyleConfig.errorColor);
      return false;
    } else {
      return true;
    }
  }
}
