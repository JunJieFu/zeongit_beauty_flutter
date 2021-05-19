import 'package:zeongitbeautyflutter/assets/entity/picture_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';

pictureEntityFromJson(PictureEntity data, Map<String, dynamic> json) {
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
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['introduction'] != null) {
		data.introduction = json['introduction'].toString();
	}
	if (json['privacy'] != null) {
		data.privacy = json['privacy'] is String
				? int.tryParse(json['privacy'])
				: json['privacy'].toInt();
	}
	if (json['viewAmount'] != null) {
		data.viewAmount = json['viewAmount'] is String
				? int.tryParse(json['viewAmount'])
				: json['viewAmount'].toInt();
	}
	if (json['likeAmount'] != null) {
		data.likeAmount = json['likeAmount'] is String
				? int.tryParse(json['likeAmount'])
				: json['likeAmount'].toInt();
	}
	if (json['width'] != null) {
		data.width = json['width'] is String
				? int.tryParse(json['width'])
				: json['width'].toInt();
	}
	if (json['height'] != null) {
		data.height = json['height'] is String
				? int.tryParse(json['height'])
				: json['height'].toInt();
	}
	if (json['url'] != null) {
		data.url = json['url'].toString();
	}
	if (json['aspectRatio'] != null) {
		data.aspectRatio = json['aspectRatio'] is String
				? int.tryParse(json['aspectRatio'])
				: json['aspectRatio'].toInt();
	}
	if (json['ratio'] != null) {
		data.ratio = json['ratio'] is String
				? double.tryParse(json['ratio'])
				: json['ratio'].toDouble();
	}
	if (json['tagList'] != null) {
		data.tagList = (json['tagList'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['focus'] != null) {
		data.focus = json['focus'] is String
				? int.tryParse(json['focus'])
				: json['focus'].toInt();
	}
	if (json['user'] != null) {
		data.user = UserInfoEntity().fromJson(json['user']);
	}
	return data;
}

Map<String, dynamic> pictureEntityToJson(PictureEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createDate'] = entity.createDate;
	data['updateDate'] = entity.updateDate;
	data['name'] = entity.name;
	data['introduction'] = entity.introduction;
	data['privacy'] = entity.privacy;
	data['viewAmount'] = entity.viewAmount;
	data['likeAmount'] = entity.likeAmount;
	data['width'] = entity.width;
	data['height'] = entity.height;
	data['url'] = entity.url;
	data['aspectRatio'] = entity.aspectRatio;
	data['ratio'] = entity.ratio;
	data['tagList'] = entity.tagList;
	data['focus'] = entity.focus;
	data['user'] = entity.user.toJson();
	return data;
}