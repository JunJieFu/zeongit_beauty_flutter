import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/constants/key.constant.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/utils/storage.util.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/link.widget.dart';
import 'package:zeongitbeautyflutter/provider/theme.logic.dart';

final _gap = StyleConfig.gap * 6;

class PalettePage extends StatelessWidget {
  final _themeLogic = Get.find<ThemeLogic>();

  @override
  Widget build(BuildContext context) {
    var color = _themeLogic.primaryColor;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("调色板"),
        ),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.all(_gap),
            child: Card(
              child: ListTile(
                  title: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Text("暗色主题"),
                    flex: 1,
                  ),
                  Switch(
                    value: Get.theme.brightness == Brightness.dark,
                    activeColor: Get.theme.primaryColor,
                    onChanged: (bool value) {
                      _themeLogic.changeTheme(isDark: value);
                    },
                  )
                ],
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(_gap, 0, _gap, _gap),
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(MdiIcons.refresh),
                          onPressed: () {
                            _themeLogic.changeTheme(
                                color: StyleConfig.primaryColor);
                          },
                        )
                      ],
                    ),
                  ),
                  ColorPicker(
                    enableAlpha: false,
                    pickerColor: color,
                    onColorChanged: (c) {
                      color = c;
                    },
                    showLabel: true,
                    pickerAreaHeightPercent: 0.8,
                  ),
                  Padding(
                    padding: EdgeInsets.all(_gap),
                    child: SizedBox(
                      height: StyleConfig.buttonHeight,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            _themeLogic.changeTheme(color: color);
                          },
                          child: Text("设置主题色")),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
