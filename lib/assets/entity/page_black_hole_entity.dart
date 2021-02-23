import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';


class PageUserBlackHoleEntity with JsonConvert<PageUserBlackHoleEntity> {
  List<UserBlackHoleEntity> items;
  Meta meta;
}

class PagePictureBlackHoleEntity with JsonConvert<PagePictureBlackHoleEntity> {
  List<PictureBlackHoleEntity> items;
  Meta meta;
}

class PageTagBlackHoleEntity with JsonConvert<PageTagBlackHoleEntity> {
  List<TagBlackHoleEntity> items;
  Meta meta;
}
