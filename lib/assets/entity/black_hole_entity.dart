import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class BlackHoleEntity with JsonConvert<BlackHoleEntity> {
	UserBlackHoleEntity user;
	List<TagBlackHoleEntity> tagList;
	PictureBlackHoleEntity picture;
}

class UserBlackHoleEntity with JsonConvert<UserBlackHoleEntity> {
	int id;
	dynamic avatarUrl;
	String nickname;
	String state;
}

class TagBlackHoleEntity with JsonConvert<TagBlackHoleEntity> {
	String name;
	String state;
}

class PictureBlackHoleEntity with JsonConvert<PictureBlackHoleEntity> {
	int id;
	String url;
	String name;
	String state;
}
