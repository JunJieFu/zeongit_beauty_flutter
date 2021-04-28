class SearchTune {
  String tagList;

  String name;

  bool precise;

  SearchTuneDateItem date = SearchTuneDateItem("不限制", null, null);

  double startWidth;

  double endWidth;

  double startHeight;

  double endHeight;

  double startRatio;

  double endRatio;

  SearchTune({
    this.tagList,
    this.name,
    this.precise,
    this.startWidth,
    this.endWidth,
    this.startHeight,
    this.endHeight
  }) {
    if (this.precise == null) precise = false;
  }
}

enum SearchTuneDate { NORMAL, WEEK, MONTH, SIX_MONTHS, YEAR, CUSTOM }

class SearchTuneDateItem {
  SearchTuneDateItem(this.text, this.startDate, this.endDate);

  String text;

  DateTime startDate;

  DateTime endDate;
}