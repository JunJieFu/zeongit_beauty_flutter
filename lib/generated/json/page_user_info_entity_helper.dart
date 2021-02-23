import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';

pageUserInfoEntityFromJson(PageUserInfoEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = new List<UserInfoEntity>();
		(json['items'] as List).forEach((v) {
			data.items.add(new UserInfoEntity().fromJson(v));
		});
	}
	if (json['meta'] != null) {
		data.meta = new Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pageUserInfoEntityToJson(PageUserInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.items != null) {
		data['items'] =  entity.items.map((v) => v.toJson()).toList();
	}
	if (entity.meta != null) {
		data['meta'] = entity.meta.toJson();
	}
	return data;
}