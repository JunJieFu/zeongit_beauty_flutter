import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';

userInfoEntityFromJson(UserInfoEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['gender'] != null) {
		data.gender = json['gender'] is String
				? int.tryParse(json['gender'])
				: json['gender'].toInt();
	}
	if (json['birthday'] != null) {
		data.birthday = json['birthday'].toString();
	}
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['introduction'] != null) {
		data.introduction = json['introduction'].toString();
	}
	if (json['avatarUrl'] != null) {
		data.avatarUrl = json['avatarUrl'];
	}
	if (json['background'] != null) {
		data.background = json['background'];
	}
	if (json['focus'] != null) {
		data.focus = json['focus'] is String
				? int.tryParse(json['focus'])
				: json['focus'].toInt();
	}
	if (json['country'] != null) {
		data.country = json['country'];
	}
	if (json['province'] != null) {
		data.province = json['province'];
	}
	if (json['city'] != null) {
		data.city = json['city'];
	}
	return data;
}

Map<String, dynamic> userInfoEntityToJson(UserInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['gender'] = entity.gender;
	data['birthday'] = entity.birthday;
	data['nickname'] = entity.nickname;
	data['introduction'] = entity.introduction;
	data['avatarUrl'] = entity.avatarUrl;
	data['background'] = entity.background;
	data['focus'] = entity.focus;
	data['country'] = entity.country;
	data['province'] = entity.province;
	data['city'] = entity.city;
	return data;
}