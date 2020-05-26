import 'package:alarm_app_animation/widgets/pick_mission_item.dart';
import 'package:flutter/material.dart';

class PickMission extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final bool shouldInitAnimation;

  const PickMission(
      {Key key, this.screenHeight, this.screenWidth, this.shouldInitAnimation})
      : super(key: key);

  @override
  _PickMissionState createState() => _PickMissionState();
}

class _PickMissionState extends State<PickMission>
    with TickerProviderStateMixin {
  double containerWidth = 0;
  AnimationController _animationControllerScale;
  Animation<double> _animationContainerScale;

  _initPickMissionAnimation() {
    _animationContainerScale =
        Tween<double>(begin: 0, end: containerWidth).animate(
      CurvedAnimation(
        parent: _animationControllerScale,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationControllerScale.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationControllerScale = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    containerWidth = widget.screenWidth / 2.5;
    _initPickMissionAnimation();
    if (widget.shouldInitAnimation) {
      _animationControllerScale.forward();
    } else {
      _animationControllerScale.reverse();
    }
    double fontSize = 14.0 *
        (1 -
            (containerWidth - _animationContainerScale.value) / containerWidth);

    return AnimatedBuilder(
      animation: _animationControllerScale,
      builder: (BuildContext context, Widget child) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9.0,
                  vertical: 11.0,
                ),
                child: Text(
                  'Pick Mission:',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  PickmissionItem(
                    containerWidth: containerWidth,
                    isActive: false,
                    icon: Icons.alarm,
                    title: 'Default',
                    animationContainerScaleValue: _animationContainerScale,
                  ),
                  PickmissionItem(
                    containerWidth: containerWidth,
                    isActive: true,
                    icon: Icons.camera_alt,
                    title: 'Take a picture',
                    animationContainerScaleValue: _animationContainerScale,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
