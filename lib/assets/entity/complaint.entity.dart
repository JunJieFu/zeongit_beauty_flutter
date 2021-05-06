import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class ComplaintEntity with JsonConvert<ComplaintEntity> {
	int createdBy;
	int state;
	int pictureId;
	String content;
	int id;
	String createDate;
	String updateDate;
}
