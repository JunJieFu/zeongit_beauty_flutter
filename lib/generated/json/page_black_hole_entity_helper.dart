import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';

pageUserBlackHoleEntityFromJson(PageUserBlackHoleEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = (json['items'] as List).map((v) => UserBlackHoleEntity().fromJson(v)).toList();
	}
	if (json['meta'] != null) {
		data.meta = Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pageUserBlackHoleEntityToJson(PageUserBlackHoleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['items'] =  entity.items.map((v) => v.toJson()).toList();
	data['meta'] = entity.meta.toJson();
	return data;
}

pagePictureBlackHoleEntityFromJson(PagePictureBlackHoleEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = (json['items'] as List).map((v) => PictureBlackHoleEntity().fromJson(v)).toList();
	}
	if (json['meta'] != null) {
		data.meta = Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pagePictureBlackHoleEntityToJson(PagePictureBlackHoleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['items'] =  entity.items.map((v) => v.toJson()).toList();
	data['meta'] = entity.meta.toJson();
	return data;
}

pageTagBlackHoleEntityFromJson(PageTagBlackHoleEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = (json['items'] as List).map((v) => TagBlackHoleEntity().fromJson(v)).toList();
	}
	if (json['meta'] != null) {
		data.meta = Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pageTagBlackHoleEntityToJson(PageTagBlackHoleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['items'] =  entity.items.map((v) => v.toJson()).toList();
	data['meta'] = entity.meta.toJson();
	return data;
}