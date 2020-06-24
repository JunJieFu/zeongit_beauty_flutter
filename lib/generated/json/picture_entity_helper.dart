import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';

pictureEntityFromJson(PictureEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['introduction'] != null) {
		data.introduction = json['introduction']?.toString();
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['privacy'] != null) {
		data.privacy = json['privacy']?.toString();
	}
	if (json['focus'] != null) {
		data.focus = json['focus']?.toString();
	}
	if (json['viewAmount'] != null) {
		data.viewAmount = json['viewAmount']?.toInt();
	}
	if (json['likeAmount'] != null) {
		data.likeAmount = json['likeAmount']?.toInt();
	}
	if (json['width'] != null) {
		data.width = json['width']?.toInt();
	}
	if (json['height'] != null) {
		data.height = json['height']?.toInt();
	}
	if (json['sizeType'] != null) {
		data.sizeType = json['sizeType']?.toString();
	}
	if (json['tagList'] != null) {
		data.tagList = json['tagList']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	if (json['user'] != null) {
		data.user = new PictureUser().fromJson(json['user']);
	}
	if (json['createDate'] != null) {
		data.createDate = json['createDate']?.toString();
	}
	return data;
}

Map<String, dynamic> pictureEntityToJson(PictureEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['introduction'] = entity.introduction;
	data['url'] = entity.url;
	data['name'] = entity.name;
	data['privacy'] = entity.privacy;
	data['focus'] = entity.focus;
	data['viewAmount'] = entity.viewAmount;
	data['likeAmount'] = entity.likeAmount;
	data['width'] = entity.width;
	data['height'] = entity.height;
	data['sizeType'] = entity.sizeType;
	data['tagList'] = entity.tagList;
	if (entity.user != null) {
		data['user'] = entity.user.toJson();
	}
	data['createDate'] = entity.createDate;
	return data;
}

pictureUserFromJson(PictureUser data, Map<String, dynamic> json) {
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

Map<String, dynamic> pictureUserToJson(PictureUser entity) {
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