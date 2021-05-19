import 'package:zeongitbeautyflutter/assets/entity/page_picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';

pagePictureEntityFromJson(PagePictureEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = (json['items'] as List).map((v) => PictureEntity().fromJson(v)).toList();
	}
	if (json['meta'] != null) {
		data.meta = Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pagePictureEntityToJson(PagePictureEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['items'] =  entity.items.map((v) => v.toJson()).toList();
	data['meta'] = entity.meta.toJson();
	return data;
}