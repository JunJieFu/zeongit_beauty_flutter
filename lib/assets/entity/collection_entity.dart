import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class CollectionEntity with JsonConvert<CollectionEntity> {
  late int id;
  late String createDate;
  late String updateDate;
  late int pictureId;
  late int focus;
  PictureEntity? picture;
}
