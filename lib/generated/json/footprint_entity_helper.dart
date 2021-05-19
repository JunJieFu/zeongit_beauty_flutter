import 'package:zeongitbeautyflutter/assets/entity/footprint_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';

footprintEntityFromJson(FootprintEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createDate'] != null) {
		data.createDate = json['createDate'].toString();
	}
	if (json['updateDate'] != null) {
		data.updateDate = json['updateDate'].toString();
	}
	if (json['pictureId'] != null) {
		data.pictureId = json['pictureId'] is String
				? int.tryParse(json['pictureId'])
				: json['pictureId'].toInt();
	}
	if (json['focus'] != null) {
		data.focus = json['focus'] is String
				? int.tryParse(json['focus'])
				: json['focus'].toInt();
	}
	if (json['picture'] != null) {
		data.picture = PictureEntity().fromJson(json['picture']);
	}
	return data;
}

Map<String, dynamic> footprintEntityToJson(FootprintEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createDate'] = entity.createDate;
	data['updateDate'] = entity.updateDate;
	data['pictureId'] = entity.pictureId;
	data['focus'] = entity.focus;
	data['picture'] = entity.picture?.toJson();
	return data;
}