import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PageableEntity with JsonConvert<PageableEntity> {
  int page;
  int size;
  String sort;

  PageableEntity({this.page = 0, this.size = 16, this.sort = "createDate,desc"});
}

class PagePageable with JsonConvert<PagePageable> {
  PageSort sort;
  int pageSize;
  int pageNumber;
  int offset;
  bool paged;
  bool unpaged;
}

class PageSort with JsonConvert<PageSort> {
  bool sorted;
  bool unsorted;
  bool empty;
}