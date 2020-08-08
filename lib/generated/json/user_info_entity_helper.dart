import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';

userInfoEntityFromJson(UserInfoEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['gender'] != null) {
		data.gender = json['gender']?.toString();
	}
	if (json['birthday'] != null) {
		data.birthday = json['birthday']?.toString();
	}
	if (json['nickname'] != null) {
		data.nickname = json['nickname']?.toString();
	}
	if (json['introduction'] != null) {
		data.introduction = json['introduction']?.toString();
	}
	if (json['avatarUrl'] != null) {
		data.avatarUrl = json['avatarUrl']?.toString();
	}
	if (json['background'] != null) {
		data.background = json['background']?.toString();
	}
	if (json['focus'] != null) {
		data.focus = json['focus']?.toString();
	}
	if (json['country'] != null) {
		data.country = json['country']?.toString();
	}
	if (json['province'] != null) {
		data.province = json['province']?.toString();
	}
	if (json['city'] != null) {
		data.city = json['city']?.toString();
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