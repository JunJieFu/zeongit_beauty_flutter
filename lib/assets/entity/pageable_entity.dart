import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class PageableEntity with JsonConvert<PageableEntity> {
	int page;
	int size;
	String sort;
}
