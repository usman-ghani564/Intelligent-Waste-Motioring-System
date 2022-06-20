import 'package:flutter/material.dart';
//import 'package:example/radar_chart/radar_chart_page.dart';
//import 'package:example/scatter_chart/scatter_chart_page.dart';

import '../widgets/bar_charts/bar_chart_page.dart';
import '../widgets/pie_charts/pie_chart_page.dart';
import '../widgets/scatter_charts/scatter_chart_page.dart';
//import 'bar_chart/bar_chart_page2.dart';
//import 'bar_chart/bar_chart_page3.dart';
//import 'line_chart/line_chart_page.dart';
//import 'line_chart/line_chart_page2.dart';
//import 'line_chart/line_chart_page3.dart';
//import 'line_chart/line_chart_page4.dart';
import '../utils/platform_info.dart';
//import 'scatter_chart/scatter_chart_page.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _currentPage = 0;

  final _controller = PageController(initialPage: 0);
  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;
  final _pages = const [
    //LineChartPage(),
    BarChartPage(),
    //BarChartPage2(),
    PieChartPage(),
    //LineChartPage2(),
    //LineChartPage3(),
    //LineChartPage4(),
    //BarChartPage3(),
    ScatterChartPage(),
    //RadarChartPage(),
  ];

  bool get isDesktopOrWeb => PlatformInfo().isDesktopOrWeb();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF006E7F),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8CB2E),
      ),
      body: SafeArea(
        child: SingleChildScrollView(child: Column(children: _pages)),
      ),
    );
  }
}
