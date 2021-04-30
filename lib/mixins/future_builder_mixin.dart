import 'package:flutter/cupertino.dart';
import 'package:zeongitbeautyflutter/assets/entity/base/result_entity.dart';

abstract class FutureBuilderAbstract<T extends StatefulWidget, S>
    extends State<T> {
  S source;

  futureBuilder();

  Future<ResultEntity<S>> fetchData();

  Widget buildMain(BuildContext context, ResultEntity<S> result);

  Widget buildError(BuildContext context);

  Widget buildSkeleton(BuildContext context);
}

mixin FutureBuilderMixin<T extends StatefulWidget, S> on State<T>
    implements FutureBuilderAbstract<T, S> {
  @override
  S source;

  @override
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
}
