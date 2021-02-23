import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';

pagePictureEntityFromJson(PagePictureEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = new List<PictureEntity>();
		(json['items'] as List).forEach((v) {
			data.items.add(new PictureEntity().fromJson(v));
		});
	}
	if (json['meta'] != null) {
		data.meta = new Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pagePictureEntityToJson(PagePictureEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.items != null) {
		data['items'] =  entity.items.map((v) => v.toJson()).toList();
	}
	if (entity.meta != null) {
		data['meta'] = entity.meta.toJson();
	}
	return data;
}