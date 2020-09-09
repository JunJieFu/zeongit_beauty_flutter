import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PageUserBlackHoleEntity with JsonConvert<PageUserBlackHoleEntity> {
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

class PagePictureBlackHoleEntity with JsonConvert<PagePictureBlackHoleEntity> {
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

class PageTagBlackHoleEntity with JsonConvert<PageTagBlackHoleEntity> {
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
