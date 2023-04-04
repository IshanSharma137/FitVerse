import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sampleproject/stat_data/chart_data.dart';

class UserStat {
  final String day;
  final int excCount;
  final charts.Color barColor;

  UserStat(
    {
      required this.day,
      required this.excCount,
      required this.barColor
    }
  );
}