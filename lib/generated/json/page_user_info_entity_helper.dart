import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';

pageUserInfoEntityFromJson(PageUserInfoEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = (json['items'] as List).map((v) => UserInfoEntity().fromJson(v)).toList();
	}
	if (json['meta'] != null) {
		data.meta = Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pageUserInfoEntityToJson(PageUserInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['items'] =  entity.items.map((v) => v.toJson()).toList();
	data['meta'] = entity.meta.toJson();
	return data;
}