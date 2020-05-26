import 'package:flutter/material.dart';

class WeekItem extends StatelessWidget {
  final String day;
  final bool isActive;
  final Animation<double> animation;
  static final double containerHeight = 40;

  const WeekItem({Key key, this.day, this.isActive, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double animationValue = animation == null ? 0 : animation.value;
    double animationValueFactor = animationValue != 0
        ? 1 - ((containerHeight - animationValue) / containerHeight)
        : animationValue;

    return Transform.scale(
      scale: isActive ? animationValueFactor : 1.0,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(
          10.0,
        ),
        width: 30,
        height: containerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: isActive
              ? Border.all(
                  color: Colors.red[200],
                )
              : null,
          color: isActive && animationValueFactor < 0.9
              ? Colors.red[200]
              : Colors.transparent,
        ),
        child: Text(
          day,
          style: TextStyle(
            color: (isActive && animationValueFactor < 0.9
                ? Colors.red[200]
                : (isActive && animationValueFactor > 0.9
                    ? Colors.black87
                    : Colors.black38)),
          ),
        ),
      ),
    );
  }
}
