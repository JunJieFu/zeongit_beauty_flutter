import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class Meta with JsonConvert<Meta> {
  int itemCount;
  int totalItems;
  int itemsPerPage;
  int totalPages;
  int currentPage;
  bool empty;
  bool first;
  bool last;
}
