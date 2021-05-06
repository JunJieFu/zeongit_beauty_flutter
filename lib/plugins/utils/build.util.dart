import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/plugins/styles/index.style.dart';

buildListTileTitle(String text, {IconData leftIcon, IconData rightIcon}) {
  var children = <Widget>[];
  if (leftIcon != null) {
    children.add(Icon(leftIcon));
  }
  children.add(Expanded(
    flex: 1,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: StyleConfig.gap * 2),
      child: Text(text),
    ),
  ));
  if (rightIcon != null) {
    children.add(Icon(rightIcon));
  }
  return Flex(
    direction: Axis.horizontal,
    children: children,
  );
}
