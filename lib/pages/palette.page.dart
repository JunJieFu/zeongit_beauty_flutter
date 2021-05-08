import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/card.widget.dart';
import 'package:zeongitbeautyflutter/plugins/widgets/title.widget.dart';
import 'package:zeongitbeautyflutter/provider/theme.getx_ctrl.dart';

final _gap = StyleConfig.gap * 6;

class PalettePage extends StatelessWidget {
  final _themeGetxCtrl = Get.find<ThemeGetxCtrl>();

  @override
  Widget build(BuildContext context) {
    var color = _themeGetxCtrl.primaryColor;
    var isDark = _themeGetxCtrl.isDark;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("调色板"),
        ),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.all(_gap),
            child: Card(
              child: ListTile(title: Text("12")),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(_gap, 0, _gap, _gap),
            child: Card(
              child: Padding(
                padding: EdgeInsets.only(top: _gap),
                child: Column(
                  children: [
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
            ),
          )
        ]));
  }
}
