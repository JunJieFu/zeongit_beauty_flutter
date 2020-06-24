import 'package:zeongitbeautyflutter/assets/entity/result_entity.dart';

resultEntityFromJson(ResultEntity data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	if (json['data'] != null) {
		data.data = json['data'];
	}
	return data;
}

Map<String, dynamic> resultEntityToJson(ResultEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	data['message'] = entity.message;
	data['data'] = entity.data;
	return data;
}