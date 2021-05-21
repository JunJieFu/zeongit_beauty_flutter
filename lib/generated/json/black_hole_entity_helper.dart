import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';

blackHoleEntityFromJson(BlackHoleEntity data, Map<String, dynamic> json) {
	if (json['user'] != null) {
		data.user = UserBlackHoleEntity().fromJson(json['user']);
	}
	if (json['tagList'] != null) {
		data.tagList = (json['tagList'] as List).map((v) => TagBlackHoleEntity().fromJson(v)).toList();
	}
	if (json['picture'] != null) {
		data.picture = PictureBlackHoleEntity().fromJson(json['picture']);
	}
	return data;
}

Map<String, dynamic> blackHoleEntityToJson(BlackHoleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['user'] = entity.user.toJson();
	data['tagList'] =  entity.tagList.map((v) => v.toJson()).toList();
	data['picture'] = entity.picture?.toJson();
	return data;
}

userBlackHoleEntityFromJson(UserBlackHoleEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['avatarUrl'] != null) {
		data.avatarUrl = json['avatarUrl'];
	}
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['state'] != null) {
		data.state = json['state'] is String
				? int.tryParse(json['state'])
				: json['state'].toInt();
	}
	return data;
}

Map<String, dynamic> userBlackHoleEntityToJson(UserBlackHoleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['avatarUrl'] = entity.avatarUrl;
	data['nickname'] = entity.nickname;
	data['state'] = entity.state;
	return data;
}

tagBlackHoleEntityFromJson(TagBlackHoleEntity data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['state'] != null) {
		data.state = json['state'] is String
				? int.tryParse(json['state'])
				: json['state'].toInt();
	}
	return data;
}

Map<String, dynamic> tagBlackHoleEntityToJson(TagBlackHoleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['state'] = entity.state;
	return data;
}

pictureBlackHoleEntityFromJson(PictureBlackHoleEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['url'] != null) {
		data.url = json['url'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'];
	}
	if (json['state'] != null) {
		data.state = json['state'];
	}
	return data;
}

Map<String, dynamic> pictureBlackHoleEntityToJson(PictureBlackHoleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['url'] = entity.url;
	data['name'] = entity.name;
	data['state'] = entity.state;
	return data;
}