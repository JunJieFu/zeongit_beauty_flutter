import 'package:zeongitbeautyflutter/generated/json/base/json_convert_content.dart';

class TagPictureEntity with JsonConvert<TagPictureEntity> {
	late String name;
	late int amount;
	String? url;
}
