import 'package:zeongitbeautyflutter/assets/entity/page_entity.dart';

pageEntityFromJson(PageEntity data, Map<String, dynamic> json) {
	if (json['content'] != null) {
		data.content = new List<dynamic>();
		data.content.addAll(json['content']);
	}
	if (json['pageable'] != null) {
		data.pageable = new PagePageable().fromJson(json['pageable']);
	}
	if (json['last'] != null) {
		data.last = json['last'];
	}
	if (json['totalPages'] != null) {
		data.totalPages = json['totalPages']?.toInt();
	}
	if (json['totalElements'] != null) {
		data.totalElements = json['totalElements']?.toInt();
	}
	if (json['first'] != null) {
		data.first = json['first'];
	}
	if (json['sort'] != null) {
		data.sort = new PageSort().fromJson(json['sort']);
	}
	if (json['number'] != null) {
		data.number = json['number']?.toInt();
	}
	if (json['numberOfElements'] != null) {
		data.numberOfElements = json['numberOfElements']?.toInt();
	}
	if (json['size'] != null) {
		data.size = json['size']?.toInt();
	}
	if (json['empty'] != null) {
		data.empty = json['empty'];
	}
	return data;
}

Map<String, dynamic> pageEntityToJson(PageEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.content != null) {
		data['content'] =  [];
	}
	if (entity.pageable != null) {
		data['pageable'] = entity.pageable.toJson();
	}
	data['last'] = entity.last;
	data['totalPages'] = entity.totalPages;
	data['totalElements'] = entity.totalElements;
	data['first'] = entity.first;
	if (entity.sort != null) {
		data['sort'] = entity.sort.toJson();
	}
	data['number'] = entity.number;
	data['numberOfElements'] = entity.numberOfElements;
	data['size'] = entity.size;
	data['empty'] = entity.empty;
	return data;
}

pagePageableFromJson(PagePageable data, Map<String, dynamic> json) {
	if (json['sort'] != null) {
		data.sort = new PagePageableSort().fromJson(json['sort']);
	}
	if (json['pageSize'] != null) {
		data.pageSize = json['pageSize']?.toInt();
	}
	if (json['pageNumber'] != null) {
		data.pageNumber = json['pageNumber']?.toInt();
	}
	if (json['offset'] != null) {
		data.offset = json['offset']?.toInt();
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

pagePageableSortFromJson(PagePageableSort data, Map<String, dynamic> json) {
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

Map<String, dynamic> pagePageableSortToJson(PagePageableSort entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['sorted'] = entity.sorted;
	data['unsorted'] = entity.unsorted;
	data['empty'] = entity.empty;
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