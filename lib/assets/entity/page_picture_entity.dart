import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PagePictureEntity
    with JsonConvert<PagePictureEntity> {
  late List<PictureEntity> items;
  late Meta meta;
}
