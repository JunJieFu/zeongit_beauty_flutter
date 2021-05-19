import 'package:zeongitbeautyflutter/assets/entity/tag_picture_entity.dart';

tagPictureEntityFromJson(TagPictureEntity data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? int.tryParse(json['amount'])
				: json['amount'].toInt();
	}
	if (json['url'] != null) {
		data.url = json['url'];
	}
	return data;
}

Map<String, dynamic> tagPictureEntityToJson(TagPictureEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['amount'] = entity.amount;
	data['url'] = entity.url;
	return data;
}