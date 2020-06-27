import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PictureUserEntity with JsonConvert<PictureUserEntity> {
  int id;
  String gender;
  String birthday;
  String nickname;
  String introduction;
  String avatarUrl;
  String background;
  String focus;
  String country;
  String province;
  String city;
}