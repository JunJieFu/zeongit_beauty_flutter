import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class UserInfoEntity with JsonConvert<UserInfoEntity> {
	late int id;
	late int gender;
	late String birthday;
	late String nickname;
	late String introduction;
	String? avatarUrl;
	String? background;
	late int focus;
	String? country;
	String? province;
	String? city;
}
