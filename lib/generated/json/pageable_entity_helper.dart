import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';

pageableEntityFromJson(PageableEntity data, Map<String, dynamic> json) {
	if (json['page'] != null) {
		data.page = json['page'] is String
				? int.tryParse(json['page'])
				: json['page'].toInt();
	}
	if (json['limit'] != null) {
		data.limit = json['limit'] is String
				? int.tryParse(json['limit'])
				: json['limit'].toInt();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'].toString();
	}
	return data;
}

Map<String, dynamic> pageableEntityToJson(PageableEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['page'] = entity.page;
	data['limit'] = entity.limit;
	data['sort'] = entity.sort;
	return data;
}