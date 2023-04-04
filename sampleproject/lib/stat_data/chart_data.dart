import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sampleproject/stat_data/chart_model.dart';


class StatChart extends StatelessWidget {
  final List<UserStat> data;

  StatChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<UserStat, String>> series = [
      charts.Series(
        id: "excCount",
        data: data,
        domainFn: (UserStat series, _) => series.day,
        measureFn: (UserStat series, _) => series.excCount,
        colorFn: (UserStat series, _) => series.barColor
      )
    ];

   
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      
      child: Card(
        color: Colors.transparent,
        child: Padding(
          
          padding: const EdgeInsets.all(10.0),
          child: Column(
            
            children: <Widget>[
              
              Text(
                "Weekly Graph: ",
                style: const TextStyle(fontWeight: FontWeight.bold,
                fontSize: 15.0,),
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}