import 'package:flutter/material.dart';

class SunMoon extends StatefulWidget {
  final Animation<double> moonSunTopAnimation;
  final Animation<double> moonSunLeftAnimation;
  final double initialTopPosition;

  const SunMoon({Key key, this.moonSunTopAnimation, this.moonSunLeftAnimation,this.initialTopPosition})
      : super(key: key);

  @override
  _SunMoonState createState() => _SunMoonState();
}

class _SunMoonState extends State<SunMoon> {
  @override
  Widget build(BuildContext context) {
    double radius = ((widget.initialTopPosition-widget.moonSunTopAnimation.value)/widget.initialTopPosition)*3;
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.yellow[200],
          gradient: RadialGradient(
            center:const Alignment(0.7, -0.6),
            colors: [
               Colors.yellow,
              Colors.blue,
            ],
            radius: radius,
          )),
    );
  }
}
