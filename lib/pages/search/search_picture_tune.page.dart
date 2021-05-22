import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zeongitbeautyflutter/assets/models/dto.model.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/popup_container.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/text.widget.dart';

final _gap = StyleConfig.gap * 6;

class SearchPictureTunePage extends HookWidget {
  SearchPictureTunePage(
      {Key? key, required this.params, required this.callback})
      : _params = params.obs,
        _nameController = TextEditingController(text: params.name),
        _startWidthController =
            TextEditingController(text: params.startWidth?.toString() ?? ""),
        _endWidthController =
            TextEditingController(text: params.endWidth?.toString() ?? ""),
        _startHeightController =
            TextEditingController(text: params.startHeight?.toString() ?? ""),
        _endHeightController =
            TextEditingController(text: params.endHeight?.toString() ?? ""),
        _startRatioController =
            TextEditingController(text: params.startRatio?.toString() ?? ""),
        _endRatioController =
            TextEditingController(text: params.endRatio?.toString() ?? ""),
        super(key: key);

  final SearchPictureTune params;

  final Function(SearchPictureTune) callback;

  final Rx<SearchPictureTune> _params;

  final GlobalKey _preciseHelpBtnKey = GlobalKey();

  final TextEditingController _nameController;
  final TextEditingController _startWidthController;
  final TextEditingController _endWidthController;
  final TextEditingController _startHeightController;
  final TextEditingController _endHeightController;
  final TextEditingController _startRatioController;
  final TextEditingController _endRatioController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("显示选项"),
        ),
        body: Obx(
          () => ListView(children: <Widget>[
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
                      value: _params.value.precise,
                      activeColor: Get.theme.primaryColor,
                      onChanged: (bool val) {
                        _params.update((source) {
                          source!.precise = val;
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
                      child: Text(_params.value.date.text),
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
                      child: Text(_params.value.date.startDate != null
                          ? DateFormat('yyyy-MM-dd')
                              .format(_params.value.date.startDate!)
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
                      child: Text(_params.value.date.endDate != null
                          ? DateFormat('yyyy-MM-dd')
                              .format(_params.value.date.endDate!)
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
              padding:
                  EdgeInsets.symmetric(vertical: _gap * 3, horizontal: _gap),
              child: SizedBox(
                width: double.infinity,
                height: StyleConfig.buttonHeight,
                child: ElevatedButton(child: Text("确定"), onPressed: tune),
              ),
            ),
          ]),
        ));
  }

  tune() {
    try {
      _params.update((val) {
        val!.name = _nameController.text;
        val.startWidth = _startWidthController.text == ""
            ? null
            : double.parse(_startWidthController.text);
        val.endWidth = _endWidthController.text == ""
            ? null
            : double.parse(_endWidthController.text);
        val.startHeight = _startHeightController.text == ""
            ? null
            : double.parse(_startHeightController.text);
        val.endHeight = _endHeightController.text == ""
            ? null
            : double.parse(_endHeightController.text);
        val.startRatio = _startRatioController.text == ""
            ? null
            : double.parse(_startRatioController.text);
        val.endRatio = _endRatioController.text == ""
            ? null
            : double.parse(_endRatioController.text);
      });

      callback(_params.value);
      Get.back();
    } catch (e) {
      BotToast.showText(text: "输入有误");
    }
  }

  SizedBox _buildLabel(String text) {
    return SizedBox(
      width: 70,
      child: Text(text, textScaleFactor: .85),
    );
  }

  _showStartDatePicker() async {
    var dateTime = await showDatePicker(
        context: Get.context!,
        initialDate: _params.value.date.startDate ??
            _params.value.date.endDate ??
            DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: _params.value.date.endDate ?? DateTime.now());

    if (dateTime != null) {
      _params.update((val) {
        val!.date.text = "自定义";
        val.date.startDate = dateTime;
      });
    }
  }

  _showEndDatePicker() async {
    var dateTime = await showDatePicker(
        context: Get.context!,
        initialDate: _params.value.date.endDate ?? DateTime.now(),
        firstDate: _params.value.date.startDate ?? DateTime(2015),
        lastDate: DateTime.now());
    if (dateTime != null) {
      _params.update((val) {
        val!.date.text = "自定义";
        val.date.startDate = dateTime;
      });
    }
  }

  _showSelectDate() {
    Map<SearchTuneDate, SearchTuneDateItem> _searchTuneDateMap = {
      SearchTuneDate.NORMAL: SearchTuneDateItem(text: "不限制"),
      SearchTuneDate.WEEK: SearchTuneDateItem(
          text: "一周内",
          startDate: DateTime.now().add(Duration(days: -7)),
          endDate: DateTime.now()),
      SearchTuneDate.MONTH: SearchTuneDateItem(
          text: "一个月内",
          startDate: DateTime.now().add(Duration(days: -30)),
          endDate: DateTime.now()),
      SearchTuneDate.SIX_MONTHS: SearchTuneDateItem(
          text: "半年内",
          startDate: DateTime.now().add(Duration(days: -186)),
          endDate: DateTime.now()),
      SearchTuneDate.YEAR: SearchTuneDateItem(
          text: "一年内",
          startDate: DateTime.now().add(Duration(days: -365)),
          endDate: DateTime.now()),
      SearchTuneDate.CUSTOM: SearchTuneDateItem(text: "自定义"),
    };
    showDialog(
        context: Get.context!,
        builder: (ctx) {
          return SimpleDialog(
              title: Text("时间选择"),
              children: _searchTuneDateMap.keys
                  .map((e) => ListTile(
                        title: Text(_searchTuneDateMap[e]!.text.toString()),
                        onTap: () {
                          _params.update((val) {
                            val!.date = _searchTuneDateMap[e]!;
                          });
                        },
                      ))
                  .toList());
        });
  }
}
