import 'package:zeongitbeautyflutter/assets/entity/collection_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PageCollectionEntity with JsonConvert<PageCollectionEntity> {
  List<CollectionEntity> items;
  Meta meta;
}
