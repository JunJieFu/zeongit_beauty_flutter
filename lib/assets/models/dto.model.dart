class SearchPictureTune {
  String? tagList;

  String? name;

  bool precise;

  SearchTuneDateItem date = SearchTuneDateItem(text: "不限制");

  double? startWidth;

  double? endWidth;

  double? startHeight;

  double? endHeight;

  double? startRatio;

  double? endRatio;

  SearchPictureTune(
      {this.tagList,
      this.name,
      this.precise = false,
      this.startWidth,
      this.endWidth,
      this.startHeight,
      this.endHeight});
}

enum SearchTuneDate { NORMAL, WEEK, MONTH, SIX_MONTHS, YEAR, CUSTOM }

class SearchTuneDateItem {
  SearchTuneDateItem({required this.text, this.startDate, this.endDate});

  String text;

  DateTime? startDate;

  DateTime? endDate;
}

class DateRange {
  DateTime? startDate;

  DateTime? endDate;
}

class SearchUserTune {
  String? nicknameList;

  bool precise;

  SearchTuneDateItem date = SearchTuneDateItem(text: "不限制");

  SearchUserTune({
    this.nicknameList,
    this.precise = false,
  });
}
