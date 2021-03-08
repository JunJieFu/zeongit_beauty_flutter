import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PictureEntity with JsonConvert<PictureEntity> {
	int id;
	String createDate;
	String updateDate;
	String name;
	String introduction;
	int privacy;
	int viewAmount;
	int likeAmount;
	int width;
	int height;
	String url;
	int aspectRatio;
	double ratio;
	List<String> tagList;
	int focus;
	UserInfoEntity user;
}

