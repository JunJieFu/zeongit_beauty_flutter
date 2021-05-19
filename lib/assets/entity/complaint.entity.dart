import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class ComplaintEntity with JsonConvert<ComplaintEntity> {
	late int createdBy;
	late int state;
	late int pictureId;
	late String content;
	late int id;
	late String createDate;
	late String updateDate;
}
