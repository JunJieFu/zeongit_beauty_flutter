import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class BlackHoleEntity with JsonConvert<BlackHoleEntity> {
  late UserBlackHoleEntity user;
  late List<TagBlackHoleEntity> tagList;
  PictureBlackHoleEntity? picture;
}

class UserBlackHoleEntity with JsonConvert<UserBlackHoleEntity> {
  late int id;
  String? avatarUrl;
  late String nickname;
	late int state;
}

class TagBlackHoleEntity with JsonConvert<TagBlackHoleEntity> {
  late String name;
  late int state;
}

class PictureBlackHoleEntity with JsonConvert<PictureBlackHoleEntity> {
  late int id;
  late String url;
  String? name;
  int? state;
}
