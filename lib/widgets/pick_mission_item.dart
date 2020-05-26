import 'package:flutter/material.dart';

class PickmissionItem extends StatelessWidget {
  final double containerWidth;
  final bool isActive;
  final IconData icon;
  final String title;
  final Animation<double> animationContainerScaleValue;

  const PickmissionItem(
      {Key key,
      this.containerWidth,
      this.isActive,
      this.icon,
      this.title,
      this.animationContainerScaleValue})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double animationScale = animationContainerScaleValue != null
        ? animationContainerScaleValue.value
        : 0;
    double scaleValue = 1 - (containerWidth - animationScale) / containerWidth;
    double iconSize = 18.0;
    double fontSize =14.0;

    return Transform.scale(
      scale: scaleValue,
      child: Container(
        width: containerWidth,
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        child: Transform.scale(
          scale: scaleValue,
          child: Container(
            width: containerWidth,
            height: 100.0,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            decoration: BoxDecoration(
              color: isActive ? Colors.grey[100] : Colors.red[300],
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  icon,
                  color: isActive ? Colors.teal[500] : Colors.white70,
                  size: scaleValue > 0.9 ? iconSize : 0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: isActive ? Colors.black87 : Colors.white70,
                    fontSize: scaleValue > 0.9 ? fontSize : 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
