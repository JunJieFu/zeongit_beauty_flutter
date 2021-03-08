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

pagePageableFromJson(PagePageable data, Map<String, dynamic> json) {
	if (json['sort'] != null) {
		data.sort = new PageSort().fromJson(json['sort']);
	}
	if (json['pageSize'] != null) {
		data.pageSize = json['pageSize'] is String
				? int.tryParse(json['pageSize'])
				: json['pageSize'].toInt();
	}
	if (json['pageNumber'] != null) {
		data.pageNumber = json['pageNumber'] is String
				? int.tryParse(json['pageNumber'])
				: json['pageNumber'].toInt();
	}
	if (json['offset'] != null) {
		data.offset = json['offset'] is String
				? int.tryParse(json['offset'])
				: json['offset'].toInt();
	}
	if (json['paged'] != null) {
		data.paged = json['paged'];
	}
	if (json['unpaged'] != null) {
		data.unpaged = json['unpaged'];
	}
	return data;
}

Map<String, dynamic> pagePageableToJson(PagePageable entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.sort != null) {
		data['sort'] = entity.sort.toJson();
	}
	data['pageSize'] = entity.pageSize;
	data['pageNumber'] = entity.pageNumber;
	data['offset'] = entity.offset;
	data['paged'] = entity.paged;
	data['unpaged'] = entity.unpaged;
	return data;
}

pageSortFromJson(PageSort data, Map<String, dynamic> json) {
	if (json['sorted'] != null) {
		data.sorted = json['sorted'];
	}
	if (json['unsorted'] != null) {
		data.unsorted = json['unsorted'];
	}
	if (json['empty'] != null) {
		data.empty = json['empty'];
	}
	return data;
}

Map<String, dynamic> pageSortToJson(PageSort entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['sorted'] = entity.sorted;
	data['unsorted'] = entity.unsorted;
	data['empty'] = entity.empty;
	return data;
}