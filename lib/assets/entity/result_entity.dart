import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class ResultEntity with JsonConvert<ResultEntity> {
	int status;
  String message;
	dynamic data;
  ResultEntity({int status, String message, dynamic data});
}
