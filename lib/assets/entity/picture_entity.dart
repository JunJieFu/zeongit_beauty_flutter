import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PictureEntity with JsonConvert<PictureEntity> {
	int id;
	String introduction;
	String url;
	String name;
	String privacy;
	String focus;
	int viewAmount;
	int likeAmount;
	int width;
	int height;
	String sizeType;
	List<String> tagList;
	PictureUser user;
	String createDate;
}

class PictureUser with JsonConvert<PictureUser> {
	int id;
	String gender;
	String birthday;
	String nickname;
	String introduction;
	String avatarUrl;
	String background;
	String focus;
	String country;
	String province;
	String city;
}
