import 'package:zeongitbeautyflutter/assets/entity/page_footprint_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/footprint_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';

pageFootprintEntityFromJson(PageFootprintEntity data, Map<String, dynamic> json) {
	if (json['items'] != null) {
		data.items = (json['items'] as List).map((v) => FootprintEntity().fromJson(v)).toList();
	}
	if (json['meta'] != null) {
		data.meta = Meta().fromJson(json['meta']);
	}
	return data;
}

Map<String, dynamic> pageFootprintEntityToJson(PageFootprintEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['items'] =  entity.items.map((v) => v.toJson()).toList();
	data['meta'] = entity.meta.toJson();
	return data;
}