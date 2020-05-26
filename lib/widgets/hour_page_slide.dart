import 'package:alarm_app_animation/models/hour.dart';
import 'package:flutter/material.dart';

class HourPageSlide extends StatefulWidget {
  final double fontSize;
  final bool isHour;
  final Function timeChangeCallback;
  final double screenHeight;
  final double screenWidth;
  static final double topPositionBegin = 450;
  static final double topPositionEnd = 430;
  static final double leftPositionBegin = -100;
  static final double leftPositionEnd = -50;

  const HourPageSlide(
      {this.fontSize,
      this.isHour,
      this.timeChangeCallback,
      this.screenHeight,
      this.screenWidth});
  @override
  _HourPageSlideState createState() => _HourPageSlideState();
}

class _HourPageSlideState extends State<HourPageSlide> {
  PageController _pageController;
  List<Hour> hoursList = [];

  double topPositionBeginLocal = HourPageSlide.topPositionBegin;
  double topPositionEndLocal = HourPageSlide.topPositionEnd;

  double leftPositionBeginLocal = HourPageSlide.leftPositionBegin;
  double leftPositionEndLocal = HourPageSlide.leftPositionEnd;

  double minInterValTop = 20;
  double minInterValLeft = 50;

  _buildHoursList() {
    int maxCount = widget.isHour ? 11 : 59;
    for (int i = 0; i <= maxCount; i++) {
      String iStr = i.toString();

      if (i <= 11) {
        topPositionBeginLocal = topPositionBeginLocal - minInterValTop;
        topPositionEndLocal = topPositionEndLocal - minInterValTop;

        leftPositionBeginLocal = leftPositionBeginLocal + minInterValLeft;
        leftPositionEndLocal = leftPositionEndLocal + minInterValLeft;
      }
      if (topPositionBeginLocal <= 0.0) {
        topPositionBeginLocal = HourPageSlide.topPositionBegin;
      }
      if (topPositionEndLocal <= 0.0) {
        topPositionEndLocal = HourPageSlide.topPositionEnd;
      }

      if (leftPositionBeginLocal > widget.screenWidth) {
        leftPositionBeginLocal = HourPageSlide.leftPositionBegin;
      }
      if (leftPositionEndLocal > widget.screenWidth) {
        leftPositionEndLocal = HourPageSlide.leftPositionEnd;
      }
      hoursList.add(
        Hour(
          timeStr: iStr.length > 1 ? iStr : '0' + iStr,
          topPositionBegin: topPositionBeginLocal,
          topPositionEnd: topPositionEndLocal,
          leftPositionBegin: leftPositionBeginLocal,
          leftPositionEnd: leftPositionEndLocal,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _buildHoursList();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var previousIndex = 0;
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: _pageController,
      itemCount: hoursList.length,
      onPageChanged: (int index) {
        bool pageViewIsForward = true;
        if (previousIndex > index) {
          pageViewIsForward = false;
        }
        if (previousIndex != index) {
          previousIndex = index;
        }
        widget.timeChangeCallback(hour:hoursList[index], isHour:widget.isHour, isInit:false,pageViewIsForward:pageViewIsForward,previousHour:hoursList[previousIndex]);
      },
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Text(
            hoursList[index].timeStr,
            style: TextStyle(
              fontSize: widget.fontSize,
            ),
          ),
        );
      },
    );
  }
}
