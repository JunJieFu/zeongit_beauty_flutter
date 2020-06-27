import 'package:zeongitbeautyflutter/assets/constant/config.constant.dart';

enum ImageType {
  specifiedWidth,
  specifiedWidth300,
  specifiedWidth500,
  specifiedWidth1200,
  specifiedHeight1200
}

class ImageUtil {
  static picture(String url, {ImageType type}) {
    return ConfigConstant.qiniuImage +
        '/' +
        url +
        ConfigConstant.qiniuSeparator +
        type.toString();
  }
}
