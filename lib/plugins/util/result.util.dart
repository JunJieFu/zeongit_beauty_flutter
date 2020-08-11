import 'package:fluttertoast/fluttertoast.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';

class ResultUtil {
  static Future check(ResultEntity result) {
    return Future(() {
      if (result.status != 200) {
        Fluttertoast.showToast(
            msg: result.message,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: StyleConfig.errorColor);
      }
      assert(result.status == 200);
    });
  }
}
