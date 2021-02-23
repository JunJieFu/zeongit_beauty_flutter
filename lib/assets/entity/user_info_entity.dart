import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class UserInfoEntity with JsonConvert<UserInfoEntity> {
	int id;
	int gender;
	String birthday;
	String nickname;
	String introduction;
	String avatarUrl;
	String background;
	int focus;
	String country;
	String province;
	String city;
}
