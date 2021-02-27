import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';

abstract class FutureBuildAbstract<T extends StatefulWidget, S>
    extends State<T> {
  S source;

  futureBuilder() {
    return FutureBuilder(
        future: fetchData(),
        builder:
            (BuildContext context, AsyncSnapshot<ResultEntity<S>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              source = snapshot.data.data;
              return buildMain(context, snapshot.data);
            } else {
              return buildError(context);
            }
          } else {
            return buildSkeleton(context);
          }
        });
  }

  Future<ResultEntity<S>> fetchData();

  Widget buildMain(BuildContext context, ResultEntity<S> result);

  Widget buildError(BuildContext context);

  Widget buildSkeleton(BuildContext context);
}
