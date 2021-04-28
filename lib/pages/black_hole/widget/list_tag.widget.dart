import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeongitbeautyflutter/assets/entity/black_hole_entity.dart';
import 'package:zeongitbeautyflutter/assets/entity/page_black_hole_entity.dart';
import 'package:zeongitbeautyflutter/plugins/style/index.style.dart';
import 'package:zeongitbeautyflutter/widget/btn/block_tag_icon_btn.widget.dart';

class ListTagWidget extends StatefulWidget {
  ListTagWidget(
      {Key key, this.currPage, this.list, this.controller, this.changePage})
      : super(key: key) {
    if (controller == null) this.controller = ScrollController();
  }

  final PageTagBlackHoleEntity currPage;

  final List<TagBlackHoleEntity> list;

  ScrollController controller;

  final Future<void> Function(int) changePage;

  @override
  _ListTagWidgetState createState() => _ListTagWidgetState();
}

class _ListTagWidgetState extends State<ListTagWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.position.maxScrollExtent -
              widget.controller.position.pixels <
          150) {
        if (widget.changePage != null) {
          widget.changePage(widget.currPage.meta.currentPage + 1);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: widget.controller,
        itemCount: widget.list?.length,
        itemBuilder: (BuildContext context, int index) {
          TagBlackHoleEntity tag = widget.list[index];
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: StyleConfig.gap * 3,
                    vertical: StyleConfig.gap * 2),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: StyleConfig.gap * 2),
                        child: Text(tag.name),
                      ),
                    ),
                    BlockTagIconBtnWidget(
                      tag: tag,
                      callback: (user, int state) {
                        setState(() {
                          widget.list[index].state = state;
                        });
                      },
                    )
                  ],
                ),
              ),
              Divider(height: 1)
            ],
          );
        });
  }
}
