import 'package:alarm_app_animation/widgets/week_item.dart';
import 'package:flutter/material.dart';

class WeekDay extends StatefulWidget {
  final BoxConstraints boxConstraints;
  final bool shouldInitAnimation;

  const WeekDay({Key key, this.boxConstraints, this.shouldInitAnimation})
      : super(key: key);
  @override
  WeekDayState createState() => WeekDayState();
}

class WeekDayState extends State<WeekDay> with TickerProviderStateMixin {
  AnimationController _dividerAnimationController;
  Animation<double> _dividerAnimation;

  AnimationController _weekDayTransformAnimationController;
  Animation<double> _weekDayTransformAnimationMonday;
  Animation<double> _weekDayTransformAnimationWednesday;
  Animation<double> _weekDayTransformAnimationFriday;

  _initTransformScaleAnimation() {
    //monday animation
    _weekDayTransformAnimationMonday =
        Tween<double>(begin: 0, end: WeekItem.containerHeight).animate(
      CurvedAnimation(
        parent: _weekDayTransformAnimationController,
        curve: Interval(
          0.0,
          0.3,
          curve: Curves.easeIn,
        ),
      ),
    );

    //wednesay animation
    _weekDayTransformAnimationWednesday =
        Tween<double>(begin: 0, end: WeekItem.containerHeight).animate(
      CurvedAnimation(
        parent: _weekDayTransformAnimationController,
        curve: Interval(
          0.3,
          0.6,
          curve: Curves.easeIn,
        ),
      ),
    );

    //friday animation
    _weekDayTransformAnimationFriday =
        Tween<double>(begin: 0, end: WeekItem.containerHeight).animate(
      CurvedAnimation(
        parent: _weekDayTransformAnimationController,
        curve: Interval(
          0.6,
          0.9,
          curve: Curves.easeIn,
        ),
      ),
    );

    if (_weekDayTransformAnimationController.isDismissed) {
      _weekDayTransformAnimationController.forward();
    }
  }

  _initDividerAnimation() {
    _dividerAnimation =
        Tween<double>(begin: 0, end: widget.boxConstraints.maxWidth).animate(
      CurvedAnimation(
        parent: _dividerAnimationController,
        curve: Curves.decelerate,
      ),
    );

    if (_dividerAnimationController.isDismissed) {
      _dividerAnimationController.forward();
    }
  }
  

  @override
  void dispose() {
    _dividerAnimationController.dispose();
    _weekDayTransformAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _dividerAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );

    _weekDayTransformAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldInitAnimation) {
      _initDividerAnimation();
      _initTransformScaleAnimation();
    }else{
      _weekDayTransformAnimationController.reverse();
      _dividerAnimationController.reverse();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AnimatedBuilder(
          animation: _dividerAnimationController,
          builder: (BuildContext context, Widget child) {
            return Container(
              height: 1.0,
              width: _dividerAnimation == null ? 0 : _dividerAnimation.value,
              color: Colors.grey[200],
            );
          },
        ),
        AnimatedBuilder(
          animation: _weekDayTransformAnimationController,
          builder: (BuildContext context, Widget child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                WeekItem(
                  day: 'S',
                  isActive: false,
                  animation: null,
                ),
                WeekItem(
                  day: 'M',
                  isActive: true,
                  animation: _weekDayTransformAnimationMonday,
                ),
                WeekItem(
                  day: 'T',
                  isActive: false,
                  animation: null,
                ),
                WeekItem(
                  day: 'W',
                  isActive: true,
                  animation: _weekDayTransformAnimationWednesday,
                ),
                WeekItem(
                  day: 'T',
                  isActive: false,
                  animation: null,
                ),
                WeekItem(
                  day: 'F',
                  isActive: true,
                  animation: _weekDayTransformAnimationFriday,
                ),
                WeekItem(
                  day: 'S',
                  isActive: false,
                  animation: null,
                ),
              ],
            );
          },
        ),
        GestureDetector(
          onTap: () {
            print('hapa');
            _initDividerAnimation();
            _initTransformScaleAnimation();
          },
          child: Container(
            height: 100.0,
            width: widget.boxConstraints.maxWidth,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
