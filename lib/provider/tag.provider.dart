import 'package:flutter/cupertino.dart';

class TagState extends ChangeNotifier {
  List<String> _recommendTagList;

  List<String> get recommendTagList => _recommendTagList;

  setRecommendTagList(List<dynamic> recommendTagList) {
    this._recommendTagList = recommendTagList.map((e) => e.toString()).toList();
    notifyListeners();
  }
}
