
import 'package:alarm_app_animation/models/hour.dart';
import 'package:alarm_app_animation/widgets/bottom_container.dart';
import 'package:alarm_app_animation/widgets/hour_page_slide.dart';
import 'package:alarm_app_animation/widgets/sound_action.dart';
import 'package:alarm_app_animation/widgets/sun_moon.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _containerAnimation;
  Animation<double> _moonSunTopAnimation;
  Tween<double> _tweenTopPosition;
  Animation<double> _moonSunLeftAnimation;
  Tween<double> _tweenLeftPosition;
  Animation<double> _containerHeightAnimation;
  double iconSize = 16.0;
  double horizontalMargin = 16.0;
  double marginTop = 50.0;
  double marginTopContainer = 150.0;

  double timerContainerHeight = 100;
  double timerContainerWidth = 80;
  double initialContainerHeight = 100;
  double containerHeight = 100;

  double containerRadius = 10.0;

  double fontSize = 36;

  bool isAm = true;
  bool isSwitched = false;

  double sunMoonInitPositionTop = 350.0;
  double sunMoonInitPositionLeft = 100.0;
  GlobalKey<SoundActionState> soundActionState = GlobalKey<SoundActionState>();

  _showBottomContainerInit(context) {
    _containerHeightAnimation = Tween<double>(
            begin: initialContainerHeight,
            end: MediaQuery.of(context).size.height)
        .animate(
      CurvedAnimation(
        parent: _containerAnimation,
        curve: Curves.easeIn,
      ),
    );
    _showBottomContainer();
  }

  _showBottomContainer() {
    if (_containerAnimation.isDismissed) {
      _containerAnimation.forward();
    } else if (_containerAnimation.isCompleted) {
      _containerAnimation.reverse();
    }
  }

  _timeSelected(
      {Hour hour,
      bool isHour,
      bool isInit,
      bool pageViewIsForward,
      Hour previousHour}) {
    if (!isHour) return;

    if (isInit) {
      //init animation controller
      _animationControllerInit();
      //prepare tween
      _tweenTopPosition =
          Tween<double>(begin: hour.topPositionBegin, end: hour.topPositionEnd);

      _tweenLeftPosition = Tween<double>(
          begin: hour.leftPositionBegin, end: hour.leftPositionEnd);

      //prepare the animation
      _moonSunTopAnimation = _tweenTopPosition.animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.ease,
        ),
      );

      _moonSunLeftAnimation = _tweenLeftPosition.animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.ease,
        ),
      );
    } else {
      _animationController.reset();
      if (pageViewIsForward == true) {
        _tweenTopPosition.begin = hour.topPositionBegin;
        _tweenTopPosition.end = hour.topPositionEnd;
      } else {
        _tweenTopPosition.begin = previousHour.topPositionEnd;
        _tweenTopPosition.end = hour.topPositionBegin;
      }

      if (pageViewIsForward == true) {
        _tweenLeftPosition.begin = hour.leftPositionBegin;
        _tweenLeftPosition.end = hour.leftPositionEnd;
      } else {
        _tweenLeftPosition.begin = previousHour.leftPositionEnd;
        _tweenLeftPosition.end = hour.leftPositionBegin;
      }
    }
    _animationController.forward();
  }

  _buildSunMoon(context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) {
        return Positioned(
          top: _moonSunTopAnimation.value,
          left: _moonSunLeftAnimation.value,
          child: SunMoon(
            moonSunTopAnimation: _moonSunTopAnimation,
            moonSunLeftAnimation: _moonSunLeftAnimation,
            initialTopPosition: HourPageSlide.topPositionBegin,
          ),
        );
      },
    );
  }

  Widget _buildMainContainer(context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _containerAnimation,
      builder: (context, child) {
        return Positioned(
          top: marginTopContainer,
          right: horizontalMargin,
          left: horizontalMargin,
          child: GestureDetector(
            onTap: () {
              _showBottomContainerInit(context);
            },
            child: Container(
              height: _containerHeightAnimation == null
                  ? containerHeight
                  : _containerHeightAnimation.value,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  containerRadius,
                ),
              ),
              child: ListView(
                padding: EdgeInsets.all(
                  0.0,
                ),
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: timerContainerWidth,
                        height: timerContainerHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(containerRadius),
                            bottomLeft: Radius.circular(containerRadius),
                          ),
                        ),
                        child: HourPageSlide(
                          fontSize: fontSize,
                          isHour: true,
                          timeChangeCallback: _timeSelected,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        ),
                      ),
                      Container(
                        width: 20.0,
                        height: timerContainerHeight,
                        child: Center(
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: timerContainerWidth,
                        height: timerContainerHeight,
                        child: HourPageSlide(
                          fontSize: fontSize,
                          isHour: false,
                          timeChangeCallback: _timeSelected,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        ),
                      ),
                      Container(
                        width: 40.0,
                        height: timerContainerHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAm = true;
                                });
                              },
                              child: Text(
                                'am',
                                style: TextStyle(
                                  fontWeight: isAm
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isAm ? Colors.black87 : Colors.black38,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isAm = false;
                                });
                              },
                              child: Text(
                                'pm',
                                style: TextStyle(
                                  fontWeight: isAm
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                  color: isAm ? Colors.black38 : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50.0,
                          ),
                          height: timerContainerHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(containerRadius),
                              bottomRight: Radius.circular(containerRadius),
                            ),
                          ),
                          child: Switch(
                            value: isSwitched,
                            onChanged: (bool selected) {
                              setState(() {
                                isSwitched = selected;
                              });
                            },
                            activeColor: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  BottomContainer(
                    containerHeightAnimation: _containerHeightAnimation,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    soundActionState: soundActionState,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _animationControllerInit() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );
  }

  _onContainerHeightAnimationDone() {
    // Future.delayed(Duration(milliseconds: 500), () {
    // print(soundActionState.currentState);
    soundActionState.currentState.runAnimation();
    // });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _containerAnimation.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _timeSelected(
      hour: Hour(
        timeStr: '00',
        topPositionBegin: HourPageSlide.topPositionBegin,
        topPositionEnd: HourPageSlide.topPositionEnd,
        leftPositionBegin: HourPageSlide.leftPositionBegin,
        leftPositionEnd: HourPageSlide.leftPositionEnd,
      ),
      isHour: true,
      isInit: true,
      pageViewIsForward: true,
    );

    _containerAnimation = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _onContainerHeightAnimationDone();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/night-sky.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: marginTop,
            right: horizontalMargin - iconSize,
            child: IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: iconSize,
                ),
                onPressed: null),
          ),
          _buildSunMoon(context),
          _buildMainContainer(context),
        ],
      ),
    );
  }
}
