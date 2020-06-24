import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';

pageableEntityFromJson(PageableEntity data, Map<String, dynamic> json) {
	if (json['page'] != null) {
		data.page = json['page']?.toInt();
	}
	if (json['size'] != null) {
		data.size = json['size']?.toInt();
	}
	if (json['sort'] != null) {
		data.sort = json['sort']?.toString();
	}
	return data;
}

Map<String, dynamic> pageableEntityToJson(PageableEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['page'] = entity.page;
	data['size'] = entity.size;
	data['sort'] = entity.sort;
	return data;
}