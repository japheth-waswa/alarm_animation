import 'package:alarm_app_animation/widgets/pick_mission.dart';
import 'package:alarm_app_animation/widgets/sound_action.dart';
import 'package:alarm_app_animation/widgets/week_day.dart';
import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  final Animation<double> containerHeightAnimation;
  final double screenHeight;
  final double screenWidth;
  final Key soundActionState;

  const BottomContainer(
      {Key key,
      this.containerHeightAnimation,
      this.screenHeight,
      this.screenWidth,
      this.soundActionState,})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double containerHeightAnimationValue =
        containerHeightAnimation != null ? containerHeightAnimation.value : 0.0;
    double containerHeightAnimationValueFactor =
        1 - (screenHeight - containerHeightAnimationValue) / screenHeight;

    bool shouldInitAnimation =
        containerHeightAnimationValueFactor > 0.8 ? true : false;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        return Column(
          children: <Widget>[
            WeekDay(
              boxConstraints: boxConstraints,
              shouldInitAnimation: shouldInitAnimation,
            ),
            PickMission(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              shouldInitAnimation: shouldInitAnimation,
            ),
            SoundAction(key:soundActionState,shouldInitAnimation: shouldInitAnimation,),
          ],
        );
      },
    );
  }
}
