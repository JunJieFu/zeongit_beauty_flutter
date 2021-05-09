import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/styles/mdi_icons.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/link.widget.dart';
import 'package:zeongitbeautyflutter/provider/theme.getx_ctrl.dart';

final _gap = StyleConfig.gap * 6;

class PalettePage extends StatelessWidget {
  final _themeGetxCtrl = Get.find<ThemeGetxCtrl>();

  @override
  Widget build(BuildContext context) {
    var color = _themeGetxCtrl.primaryColor;
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
                    value: _themeGetxCtrl.isDark,
                    activeColor: Get.theme.primaryColor,
                    onChanged: (_) {
                      _themeGetxCtrl.updateTheme();
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
                            _themeGetxCtrl
                                .updatePrimaryColor(StyleConfig.primaryColor);
                          },
                        )
                      ],
                    ),
                  ),
                  ColorPicker(
                    enableAlpha: false,
                    pickerColor: _themeGetxCtrl.primaryColor,
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
                            _themeGetxCtrl.updatePrimaryColor(color);
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
