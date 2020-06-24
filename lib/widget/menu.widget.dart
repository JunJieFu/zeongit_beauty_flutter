import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'fragment/ink_clip.widget.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      AspectRatio(
        aspectRatio: 2,
        child: Ink(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/welcome.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Flex(direction: Axis.horizontal, children: <Widget>[
                  InkClipWidget(
                    child: Container(
                      child: SvgPicture.asset('assets/images/default-head.svg'),
                      decoration: BoxDecoration(
                        color: Color(0x12000000),
                      ),
                    ),
                    onTap: () {
                      print("1");
                    },
                  )
                ]))),
      ),
      ListTile(
        title: Text('猜你喜欢'),
      ),
      ListTile(
        title: Text('本站最新'),
      ),
    ]);
  }
}
