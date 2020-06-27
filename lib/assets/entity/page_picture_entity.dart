import 'package:zeongitbeautyflutter/assets/entity/base/page_base_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PagePictureEntity
    with JsonConvert<PagePictureEntity>, PageBaseEntity<PictureEntity> {
  List<PictureEntity> content;
  PagePageable pageable;
  bool last;
  int totalPages;
  int totalElements;
  bool first;
  PageSort sort;
  int number;
  int numberOfElements;
  int size;
  bool empty;
}
