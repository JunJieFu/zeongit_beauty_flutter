import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:intl/intl.dart';
import 'package:zeongitbeautyflutter/plugins/widget/popup_container.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widget/text.widget.dart';

class SearchTuneParams {
  String name;

  bool precise = false;

  _SearchTuneDateItem date = _SearchTuneDateItem("不限制", null, null);

  SearchTuneParams();
}

enum _SearchTuneDate { normal, week, month, halfAYear, year, custom }

class _SearchTuneDateItem {
  _SearchTuneDateItem(this.text, this.startDate, this.endDate);

  String text;

  DateTime startDate;

  DateTime endDate;
}

final _gap = StyleConfig.gap * 6;

class SearchTunePage extends StatefulWidget {
  SearchTunePage({Key key, @required this.params, @required this.callback})
      : super(key: key);

  final SearchTuneParams params;

  final Function callback;

  @override
  _SearchTunePageState createState() => _SearchTunePageState();
}

class _SearchTunePageState extends State<SearchTunePage> {
  TextEditingController nameController = TextEditingController();

  final GlobalKey _preciseHelpBtnKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.params.name;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("显示选项"),
        ),
        body: ListView(children: <Widget>[
          ListTile(
            title: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                buildLabel("图片名"),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "搜索网站绘画",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          ListTile(
            title: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                buildLabel("精准搜索"),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                  child: Switch(
                    value: widget.params.precise,
                    onChanged: (bool val) {
                      setState(() {
                        widget.params.precise = val;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        key: _preciseHelpBtnKey,
                        icon: Icon(Icons.help_outline),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PopupContainerRoute(
                              child: PopupContainer(
                                targetRenderKey: _preciseHelpBtnKey,
                                child: Card(
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(StyleConfig.gap * 2),
                                    width: 250,
                                    child: TextWidget(
                                        "在精准搜索下，只会显示您输入的图片名和标签名完全一致的结果。"),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                )
              ],
            ),
          ),
          Divider(height: 1),
          ListTile(
            title: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                buildLabel("上传日期"),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: Text(widget.params.date.text),
                  ),
                ),
              ],
            ),
            onTap: showSelectDate,
          ),
          Divider(height: 1),
          ListTile(
            title: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                buildLabel("开始日期"),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: Text(widget.params.date.endDate != null
                        ? DateFormat('yyyy-MM-dd')
                            .format(widget.params.date.startDate)
                        : ""),
                  ),
                ),
              ],
            ),
            onTap: showStartDatePicker,
          ),
          Divider(height: 1),
          ListTile(
            title: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                buildLabel("结束日期"),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: Text(widget.params.date.endDate != null
                        ? DateFormat('yyyy-MM-dd')
                            .format(widget.params.date.endDate)
                        : ""),
                  ),
                ),
              ],
            ),
            onTap: showEndDatePicker,
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.fromLTRB(_gap, _gap * 3, _gap, 0),
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: RaisedButton(
                textColor: Colors.white,
                color: StyleConfig.primaryColor,
                child: Text("确定"),
                onPressed: () {
                  widget.params.name = nameController.text;
                  widget.callback(widget.params);
                  Navigator.maybePop(context);
                },
              ),
            ),
          ),
        ]));
  }

  SizedBox buildLabel(String text) {
    return SizedBox(
      width: 70,
      child: Text(text,
          style: TextStyle(color: StyleConfig.titleColor),
          textScaleFactor: .85),
    );
  }

  showStartDatePicker() async {
    var dateTime = await showDatePicker(
        context: context,
        initialDate: widget.params.date.startDate ??
            widget.params.date.endDate ??
            DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: widget.params.date.endDate ?? DateTime.now());

    if (dateTime != null) {
      setState(() {
        widget.params.date.text = "自定义";
        widget.params.date.startDate = dateTime;
      });
    }
  }

  showEndDatePicker() async {
    var dateTime = await showDatePicker(
        context: context,
        initialDate: widget.params.date.endDate ?? DateTime.now(),
        firstDate: widget.params.date.startDate ?? DateTime(2015),
        lastDate: DateTime.now());
    if (dateTime != null) {
      setState(() {
        widget.params.date.text = "自定义";
        widget.params.date.endDate = dateTime;
      });
    }
  }

  showSelectDate() {
    Map<_SearchTuneDate, _SearchTuneDateItem> _searchTuneDateMap = {
      _SearchTuneDate.normal: _SearchTuneDateItem("不限制", null, null),
      _SearchTuneDate.week: _SearchTuneDateItem(
          "一周内", DateTime.now().add(Duration(days: -7)), DateTime.now()),
      _SearchTuneDate.month: _SearchTuneDateItem(
          "一个月内", DateTime.now().add(Duration(days: -30)), DateTime.now()),
      _SearchTuneDate.halfAYear: _SearchTuneDateItem(
          "半年内", DateTime.now().add(Duration(days: -186)), DateTime.now()),
      _SearchTuneDate.year: _SearchTuneDateItem(
          "一年内", DateTime.now().add(Duration(days: -365)), DateTime.now()),
      _SearchTuneDate.custom: _SearchTuneDateItem("自定义", null, null),
    };
    showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
              title: Text("时间选择"),
              children: _searchTuneDateMap.keys
                  .map((e) => ListTile(
                        title: Text(_searchTuneDateMap[e].text.toString()),
                        onTap: () {
                          setState(() {
                            widget.params.date = _searchTuneDateMap[e];
                            Navigator.maybePop(context);
                          });
                        },
                      ))
                  .toList());
        });
  }
}
