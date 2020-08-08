import 'package:zeongitbeautyflutter/assets/entity/user_info_entity.dart';
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
	UserInfoEntity user;
	String createDate;
}

