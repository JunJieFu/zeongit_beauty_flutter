import 'package:zeongitbeautyflutter/assets/entity/pagination_entity.dart';

metaFromJson(Meta data, Map<String, dynamic> json) {
	if (json['itemCount'] != null) {
		data.itemCount = json['itemCount']?.toInt();
	}
	if (json['totalItems'] != null) {
		data.totalItems = json['totalItems']?.toInt();
	}
	if (json['itemsPerPage'] != null) {
		data.itemsPerPage = json['itemsPerPage']?.toInt();
	}
	if (json['totalPages'] != null) {
		data.totalPages = json['totalPages']?.toInt();
	}
	if (json['currentPage'] != null) {
		data.currentPage = json['currentPage']?.toInt();
	}
	if (json['empty'] != null) {
		data.empty = json['empty'];
	}
	if (json['first'] != null) {
		data.first = json['first'];
	}
	if (json['last'] != null) {
		data.last = json['last'];
	}
	return data;
}

Map<String, dynamic> metaToJson(Meta entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['itemCount'] = entity.itemCount;
	data['totalItems'] = entity.totalItems;
	data['itemsPerPage'] = entity.itemsPerPage;
	data['totalPages'] = entity.totalPages;
	data['currentPage'] = entity.currentPage;
	data['empty'] = entity.empty;
	data['first'] = entity.first;
	data['last'] = entity.last;
	return data;
}