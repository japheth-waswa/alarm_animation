import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class FlareAnimation extends StatefulWidget {
  final double screenWidth;
  final bool shouldInitAnimation;

  const FlareAnimation({Key key, this.screenWidth, this.shouldInitAnimation})
      : super(key: key);

  @override
  _FlareAnimationState createState() => _FlareAnimationState();
}

class _FlareAnimationState extends State<FlareAnimation> {
  String animationName;

  @override
  Widget build(BuildContext context) {
    if (widget.shouldInitAnimation) {
      animationName = 'Still Animation';
    } else {
      animationName = null;
    }
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 100.0,
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: widget.screenWidth,
            height: 250.0,
            child: FlareActor(
              'assets/rive/couch_animation.flr',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: animationName,
            ),
          ),
        ],
      ),
    );
  }
}
