import 'package:zeongitbeautyflutter/assets/entity/page_collection_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/collection_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';

pageCollectionEntityFromJson(PageCollectionEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = new List<CollectionEntity>();
		(json['items'] as List).forEach((v) {
			data.items.add(new CollectionEntity().fromJson(v));
		});
	}
	if (json['meta'] != null) {
		data.meta = new Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pageCollectionEntityToJson(PageCollectionEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.items != null) {
		data['items'] =  entity.items.map((v) => v.toJson()).toList();
	}
	if (entity.meta != null) {
		data['meta'] = entity.meta.toJson();
	}
	return data;
}