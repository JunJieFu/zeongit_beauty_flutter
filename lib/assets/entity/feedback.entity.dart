import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class FeedbackEntity with JsonConvert<FeedbackEntity> {
	late int createdBy;
	late int state;
	String? email;
	late String content;
	late int id;
	late String createDate;
	late String updateDate;
}
