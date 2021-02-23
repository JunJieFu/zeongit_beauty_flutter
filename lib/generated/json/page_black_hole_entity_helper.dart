import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';

pageUserBlackHoleEntityFromJson(PageUserBlackHoleEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = new List<UserBlackHoleEntity>();
		(json['items'] as List).forEach((v) {
			data.items.add(new UserBlackHoleEntity().fromJson(v));
		});
	}
	if (json['meta'] != null) {
		data.meta = new Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pageUserBlackHoleEntityToJson(PageUserBlackHoleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.items != null) {
		data['items'] =  entity.items.map((v) => v.toJson()).toList();
	}
	if (entity.meta != null) {
		data['meta'] = entity.meta.toJson();
	}
	return data;
}

pagePictureBlackHoleEntityFromJson(PagePictureBlackHoleEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = new List<PictureBlackHoleEntity>();
		(json['items'] as List).forEach((v) {
			data.items.add(new PictureBlackHoleEntity().fromJson(v));
		});
	}
	if (json['meta'] != null) {
		data.meta = new Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pagePictureBlackHoleEntityToJson(PagePictureBlackHoleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.items != null) {
		data['items'] =  entity.items.map((v) => v.toJson()).toList();
	}
	if (entity.meta != null) {
		data['meta'] = entity.meta.toJson();
	}
	return data;
}

pageTagBlackHoleEntityFromJson(PageTagBlackHoleEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = new List<TagBlackHoleEntity>();
		(json['items'] as List).forEach((v) {
			data.items.add(new TagBlackHoleEntity().fromJson(v));
		});
	}
	if (json['meta'] != null) {
		data.meta = new Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pageTagBlackHoleEntityToJson(PageTagBlackHoleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.items != null) {
		data['items'] =  entity.items.map((v) => v.toJson()).toList();
	}
	if (entity.meta != null) {
		data['meta'] = entity.meta.toJson();
	}
	return data;
}