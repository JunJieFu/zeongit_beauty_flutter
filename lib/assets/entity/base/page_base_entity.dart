import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';

class PageBaseEntity<T> {
  List<T> content;
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
