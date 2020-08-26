import 'package:zeongitbeautyflutter/assets/entity/page_user_info_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/pageable_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';

pageUserInfoEntityFromJson(PageUserInfoEntity data, Map<String, dynamic> json) {
	if (json['content'] != null) {
		data.content = new List<UserInfoEntity>();
		(json['content'] as List).forEach((v) {
			data.content.add(new UserInfoEntity().fromJson(v));
		});
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

Map<String, dynamic> pageUserInfoEntityToJson(PageUserInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.content != null) {
		data['content'] =  entity.content.map((v) => v.toJson()).toList();
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