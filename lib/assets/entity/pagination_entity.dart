import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class Meta with JsonConvert<Meta> {
  late int itemCount;
  late int totalItems;
  late int itemsPerPage;
  late int totalPages;
  late int currentPage;
  late bool empty;
  late bool first;
  late bool last;
}
