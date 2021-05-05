import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/entity/tag_frequency_entity.dart';

class TagState extends ChangeNotifier {
  List<TagFrequencyEntity> _recommendTagList;

  List<TagFrequencyEntity> get recommendTagList => _recommendTagList;

  setRecommendTagList(List<TagFrequencyEntity> recommendTagList) {
    this._recommendTagList = recommendTagList;
    notifyListeners();
  }
}
