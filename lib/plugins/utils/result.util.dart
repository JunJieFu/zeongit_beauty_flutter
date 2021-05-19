import 'package:bot_toast/bot_toast.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';
import 'package:zeongitbeautyflutter/plugins/constants/status.constant.dart';

class ResultUtil {
  static bool check(ResultEntity result) {
    if (result.status != StatusCode.SUCCESS) {
      BotToast.showText(text: result.message!);
      return false;
    } else {
      return true;
    }
  }
}
