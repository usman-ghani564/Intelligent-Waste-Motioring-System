import 'package:flutter/material.dart';
import 'package:fyp_prototype/widgets/bar_chart_samples/bar_chart_sample3.dart';

import '../bar_chart_samples/bar_chart_sample3.dart';

class BarChartPage extends StatelessWidget {
  const BarChartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0XFF006E7F),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(28.0),
          child: BarChartSample3(),
        ),
      ),
    );
  }
}
