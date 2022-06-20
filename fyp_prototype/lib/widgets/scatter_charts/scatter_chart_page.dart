import 'package:flutter/material.dart';

import '../scatter_chart_samples/scatter_chart_sample1.dart';
import '../scatter_chart_samples/scatter_chart_sample2.dart';

class ScatterChartPage extends StatelessWidget {
  final Color barColor = Colors.white;
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final double width = 22;

  const ScatterChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 18.0),
            child: ScatterChartSample1(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 18.0),
            child: ScatterChartSample2(),
          )
        ],
      ),
    );
  }
}
