import 'package:flutter/cupertino.dart';

class TagState extends ChangeNotifier {
  List<String> _recommendTagList;

  List<String> get recommendTagList => _recommendTagList;

  setRecommendTagList(recommendTagList) {
    this._recommendTagList = recommendTagList;
    notifyListeners();
  }
}
