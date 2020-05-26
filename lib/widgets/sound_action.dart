
import 'package:flutter/material.dart';

class SoundAction extends StatefulWidget {
  final bool shouldInitAnimation;

  const SoundAction({Key key, this.shouldInitAnimation}) : super(key: key);
  @override
  SoundActionState createState() => SoundActionState();
}

class SoundActionState extends State<SoundAction>
    with TickerProviderStateMixin {
  AnimationController _animationControllerSound;
  Animation<double> _scaleAnimation;
  double containerSize = 15.0;

  runAnimation() {
    _animationControllerSound.forward();
  }

  @override
  void dispose() {
    _animationControllerSound.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationControllerSound = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _scaleAnimation = Tween<double>(begin: 0, end: containerSize).animate(
      CurvedAnimation(
        parent: _animationControllerSound,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.shouldInitAnimation) {
      _animationControllerSound.reverse();
    }

    double fontSize = 14.0;

    double animationScale = _scaleAnimation != null ? _scaleAnimation.value : 0;
    double scaleValue = 1 - (containerSize - animationScale) / containerSize;
    
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 19.0,
        vertical: 16.0,
      ),
      child: Transform.scale(
        scale: scaleValue,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Sound',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                  ),
                ),
                Text(
                  'Orkney',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 2.0,
                          color: Colors.red[300],
                        ),
                      ),
                      Container(
                        height: containerSize,
                        width: containerSize,
                        decoration: BoxDecoration(
                          color: Colors.red[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2.0,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Icon(
                  Icons.vibration,
                  color: Colors.teal[300],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
