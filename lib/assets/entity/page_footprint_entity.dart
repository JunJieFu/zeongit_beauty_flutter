import 'package:zeongitbeautyflutter/assets/entity/footprint_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PageFootprintEntity with JsonConvert<PageFootprintEntity> {
  List<FootprintEntity> items;
  Meta meta;
}
