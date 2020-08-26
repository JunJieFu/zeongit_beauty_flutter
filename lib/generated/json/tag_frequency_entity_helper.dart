import 'package:zeongitbeautyflutter/assets/entity/tag_frequency_entity.dart';

tagFrequencyEntityFromJson(TagFrequencyEntity data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['amount'] != null) {
		data.amount = json['amount']?.toInt();
	}
	return data;
}

Map<String, dynamic> tagFrequencyEntityToJson(TagFrequencyEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['amount'] = entity.amount;
	return data;
}