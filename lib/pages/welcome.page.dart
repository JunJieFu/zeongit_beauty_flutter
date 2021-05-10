import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';
import 'package:zeongitbeautyflutter/provider/fragment.logic.dart';

class WelcomePage extends StatelessWidget {
  final _fragmentLogic = Get.find<FragmentLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(
                    image: AssetImage('assets/images/welcome.png'),
                    fit: BoxFit.cover),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: StyleConfig.gap * 10),
                      child: SizedBox(
                        width: 120,
                        height: 48,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              textStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                              primary: Colors.white,
                              side:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          onPressed: _fragmentLogic.updateHadInit,
                          child: Text("进入首页"),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
