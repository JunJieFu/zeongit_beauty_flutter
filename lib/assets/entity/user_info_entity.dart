import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class UserInfoEntity with JsonConvert<UserInfoEntity> {
	int id;
	String gender;
	String birthday;
	String nickname;
	String introduction;
	String avatarUrl;
	String background;
	String focus;
	String country;
	dynamic province;
	dynamic city;
}
