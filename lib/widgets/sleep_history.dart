import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class SleepHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 250,
      child: Echarts(
        option: '''
      {
        legend:{
          data:['Awake', 'Rem', 'Light', 'Deep']
        },
        grid:{
          left: '3%',
          right: '8%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: {
          type: 'value'
        },
        yAxis: {
          type: 'category',
          data: ['Sat','Fri','Thu','Wed','Tue','Mon','Sun']
        },
        series: [
          {
            name: 'Awake',
            type: 'bar',
            stack: 'total',
            data: [1, 17, 5, 8, 3, 10, 23]
          },
          {
            name: 'Rem',
            type: 'bar',
            stack: 'total',
            data: [13, 23, 15, 13, 24, 13, 15]
          },
          {
            name: 'Light',
            type: 'bar',
            stack: 'total',
            data: [9, 19, 17, 7, 16, 17, 13]
          },
           {
            name: 'Deep',
            type: 'bar',
            stack: 'total',
            data: [7, 10, 21, 18, 13, 19, 8]
          },
        ]
      }
      ''',
      ),
    );
  }
}
