import 'package:zeongitbeautyflutter/assets/entity/base/page_base_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PageUserBlackHoleEntity
    with
        JsonConvert<UserBlackHoleEntity>,
        PageBaseEntity<UserBlackHoleEntity> {
  List<UserBlackHoleEntity> content;
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

class PagePictureBlackHoleEntity
    with
        JsonConvert<PictureBlackHoleEntity>,
        PageBaseEntity<PictureBlackHoleEntity> {
  List<PictureBlackHoleEntity> content;
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


class PageTagBlackHoleEntity
    with
        JsonConvert<TagBlackHoleEntity>,
        PageBaseEntity<TagBlackHoleEntity> {
  List<TagBlackHoleEntity> content;
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
