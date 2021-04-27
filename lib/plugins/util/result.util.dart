import 'package:fluttertoast/fluttertoast.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/plugins/constant/status.constant.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';

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
