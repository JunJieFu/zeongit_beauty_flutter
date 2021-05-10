import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class FootprintEntity with JsonConvert<FootprintEntity> {
  int id;
  String createDate;
  String updateDate;
  int pictureId;
  int focus;
  PictureEntity picture;
}
