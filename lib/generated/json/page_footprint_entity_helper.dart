import 'package:zeongitbeautyflutter/assets/entity/page_footprint_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/footprint_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';

pageFootprintEntityFromJson(PageFootprintEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = new List<FootprintEntity>();
		(json['items'] as List).forEach((v) {
			data.items.add(new FootprintEntity().fromJson(v));
		});
	}
	if (json['meta'] != null) {
		data.meta = new Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pageFootprintEntityToJson(PageFootprintEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.items != null) {
		data['items'] =  entity.items.map((v) => v.toJson()).toList();
	}
	if (entity.meta != null) {
		data['meta'] = entity.meta.toJson();
	}
	return data;
}