import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/popup_container.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/text.widget.dart';

final _gap = StyleConfig.gap * 6;

class SearchPictureTunePage extends StatefulWidget {
  SearchPictureTunePage(
      {Key key, @required this.params, @required this.callback})
      : super(key: key);

  final SearchPictureTune params;

  final Function(SearchPictureTune) callback;

  @override
  _SearchPictureTunePageState createState() => _SearchPictureTunePageState();
}

class _SearchPictureTunePageState extends State<SearchPictureTunePage> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _startWidthController = TextEditingController();
  TextEditingController _endWidthController = TextEditingController();

  TextEditingController _startHeightController = TextEditingController();
  TextEditingController _endHeightController = TextEditingController();

  TextEditingController _startRatioController = TextEditingController();
  TextEditingController _endRatioController = TextEditingController();

  final GlobalKey _preciseHelpBtnKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.params.name;
    _startWidthController.text = widget.params.startWidth == null
        ? ""
        : widget.params.startWidth.toString();
    _endWidthController.text =
        widget.params.endWidth == null ? "" : widget.params.endWidth.toString();
    _startHeightController.text = widget.params.startHeight == null
        ? ""
        : widget.params.startHeight.toString();
    _endHeightController.text = widget.params.endHeight == null
        ? ""
        : widget.params.endHeight.toString();
    _startRatioController.text = widget.params.startRatio == null
        ? ""
        : widget.params.startRatio.toString();
    _endRatioController.text =
        widget.params.endRatio == null ? "" : widget.params.endRatio.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
                _buildLabel("图片名"),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "请输入绘画名称",
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
                _buildLabel("精准搜索"),
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
                _buildLabel("上传日期"),
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
            onTap: _showSelectDate,
          ),
          Divider(height: 1),
          ListTile(
            title: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                _buildLabel("开始日期"),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: Text(widget.params.date.startDate != null
                        ? DateFormat('yyyy-MM-dd')
                            .format(widget.params.date.startDate)
                        : ""),
                  ),
                ),
              ],
            ),
            onTap: _showStartDatePicker,
          ),
          Divider(height: 1),
          ListTile(
            title: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                _buildLabel("结束日期"),
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
            onTap: _showEndDatePicker,
          ),
          Divider(height: 1),
          ListTile(
            title: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                _buildLabel("最小宽度"),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _startWidthController,
                      decoration: InputDecoration(
                        hintText: "请输入最小宽度",
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
                _buildLabel("最大宽度"),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _endWidthController,
                      decoration: InputDecoration(
                        hintText: "请输入最大宽度",
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
                _buildLabel("最小高度"),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _startHeightController,
                      decoration: InputDecoration(
                        hintText: "请输入最小高度",
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
                _buildLabel("最大高度"),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _endHeightController,
                      decoration: InputDecoration(
                        hintText: "请输入最大高度",
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
                _buildLabel("最小比例"),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _startRatioController,
                      decoration: InputDecoration(
                        hintText: "请输入最小宽高比例",
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
                _buildLabel("最大比例"),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _endRatioController,
                      decoration: InputDecoration(
                        hintText: "请输入最大宽高比例",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(vertical: _gap * 3, horizontal: _gap),
            child: SizedBox(
              width: double.infinity,
              height: StyleConfig.buttonHeight,
              child: ElevatedButton(
                child: Text("确定"),
                onPressed: () {
                  try {
                    widget.params.name = _nameController.text;
                    widget.params.startWidth = _startWidthController.text == ""
                        ? null
                        : double.parse(_startWidthController.text);
                    widget.params.endWidth = _endWidthController.text == ""
                        ? null
                        : double.parse(_endWidthController.text);
                    widget.params.startHeight =
                        _startHeightController.text == ""
                            ? null
                            : double.parse(_startHeightController.text);
                    widget.params.endHeight = _endHeightController.text == ""
                        ? null
                        : double.parse(_endHeightController.text);
                    widget.params.startRatio = _startRatioController.text == ""
                        ? null
                        : double.parse(_startRatioController.text);
                    widget.params.endRatio = _endRatioController.text == ""
                        ? null
                        : double.parse(_endRatioController.text);
                    widget.callback(widget.params);
                    Navigator.maybePop(context);
                  } catch (e) {
                    Fluttertoast.showToast(
                        msg: "输入有误",
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: StyleConfig.errorColor);
                  }
                },
              ),
            ),
          ),
        ]));
  }

  SizedBox _buildLabel(String text) {
    return SizedBox(
      width: 70,
      child: Text(text,
          style: TextStyle(color: StyleConfig.titleColor),
          textScaleFactor: .85),
    );
  }

  _showStartDatePicker() async {
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

  _showEndDatePicker() async {
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

  _showSelectDate() {
    Map<SearchTuneDate, SearchTuneDateItem> _searchTuneDateMap = {
      SearchTuneDate.NORMAL: SearchTuneDateItem("不限制", null, null),
      SearchTuneDate.WEEK: SearchTuneDateItem(
          "一周内", DateTime.now().add(Duration(days: -7)), DateTime.now()),
      SearchTuneDate.MONTH: SearchTuneDateItem(
          "一个月内", DateTime.now().add(Duration(days: -30)), DateTime.now()),
      SearchTuneDate.SIX_MONTHS: SearchTuneDateItem(
          "半年内", DateTime.now().add(Duration(days: -186)), DateTime.now()),
      SearchTuneDate.YEAR: SearchTuneDateItem(
          "一年内", DateTime.now().add(Duration(days: -365)), DateTime.now()),
      SearchTuneDate.CUSTOM: SearchTuneDateItem("自定义", null, null),
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
