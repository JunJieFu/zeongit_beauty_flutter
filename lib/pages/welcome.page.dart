import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeongitbeautyflutter/pages/home/tab.page.dart';
import 'package:zeongitbeautyflutter/provider/fragment.provider.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var fragmentState = Provider.of<FragmentState>(context, listen: false);
    return Scaffold(
        body: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: GestureDetector(
                child: Image(
                    image: AssetImage('assets/images/welcome.png'),
                    fit: BoxFit.cover),
                onTap: () async {
                  fragmentState.updateHadInit();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                    return TabPage();
                  }));
                })));
  }
}
