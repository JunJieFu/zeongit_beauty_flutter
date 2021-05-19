import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';


class PageUserBlackHoleEntity with JsonConvert<PageUserBlackHoleEntity> {
  late List<UserBlackHoleEntity> items;
  late Meta meta;
}

class PagePictureBlackHoleEntity with JsonConvert<PagePictureBlackHoleEntity> {
  late List<PictureBlackHoleEntity> items;
  late Meta meta;
}

class PageTagBlackHoleEntity with JsonConvert<PageTagBlackHoleEntity> {
  late List<TagBlackHoleEntity> items;
  late Meta meta;
}
