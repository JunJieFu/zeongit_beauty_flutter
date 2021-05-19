import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PageUserInfoEntity
    with JsonConvert<PageUserInfoEntity> {
  late List<UserInfoEntity> items;
  late Meta meta;
}
