import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PictureEntity with JsonConvert<PictureEntity> {
  late int id;
  late String createDate;
  late String updateDate;
  late String name;
  late String introduction;
  late int privacy;
  late int viewAmount;
  late int likeAmount;
  late int width;
  late int height;
  late String url;
  late int aspectRatio;
  late double ratio;
  late List<String> tagList;
  late int focus;
  late UserInfoEntity user;
}
