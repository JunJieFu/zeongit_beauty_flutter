import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class FeedbackEntity with JsonConvert<FeedbackEntity> {
	int createdBy;
	int state;
	String email;
	String content;
	int id;
	String createDate;
	String updateDate;
}
