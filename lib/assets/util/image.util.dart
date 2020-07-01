import 'package:zeongitbeautyflutter/assets/constant/config.constant.dart';

enum ImageType {
  specifiedWidth,
  specifiedWidth300,
  specifiedWidth500,
  specifiedWidth1200,
  specifiedHeight1200
}

enum AVATAR_TYPE { small50, small100, small200 }

class ImageUtil {
  static picture(String url, {ImageType type}) {
    if (type != null) {
      return ConfigConstant.qiniuImage +
          '/' +
          url +
          ConfigConstant.qiniuSeparator +
          type.toString().split('.').last;
    } else {
      return ConfigConstant.qiniuImage + '/' + url;
    }
  }

  static avatar(String url, {AVATAR_TYPE type}) {
    if (type != null) {
      return ConfigConstant.qiniuAvatar +
          '/' +
          url +
          ConfigConstant.qiniuSeparator +
          type.toString().split('.').last;
    } else {
      return ConfigConstant.qiniuAvatar + '/' + url;
    }
  }
}
