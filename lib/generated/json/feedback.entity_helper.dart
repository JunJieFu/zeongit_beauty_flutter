import 'package:zeongitbeautyflutter/assets/entity/feedback.entity.dart';

feedbackEntityFromJson(FeedbackEntity data, Map<String, dynamic> json) {
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['state'] != null) {
		data.state = json['state'] is String
				? int.tryParse(json['state'])
				: json['state'].toInt();
	}
	if (json['email'] != null) {
		data.email = json['email'];
	}
	if (json['content'] != null) {
		data.content = json['content'].toString();
	}
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
	return data;
}

Map<String, dynamic> feedbackEntityToJson(FeedbackEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['createdBy'] = entity.createdBy;
	data['state'] = entity.state;
	data['email'] = entity.email;
	data['content'] = entity.content;
	data['id'] = entity.id;
	data['createDate'] = entity.createDate;
	data['updateDate'] = entity.updateDate;
	return data;
}