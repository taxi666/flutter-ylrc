import 'package:flutter/material.dart';
import './pages/TestCenter.dart';
import 'login_screen.dart';
import 'globals.dart' as globals;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds:1));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    /* 动画事件监听器
    监听动画的执行状态，这里监听动画结束的状态，如果结束则执行页面跳转
     */
    _animation.addStatusListener((status){
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context)  {
            return globals.isLoggedIn? NewRouteTestCenter():LoginView();
          }),
        (route) => route==null
        );
      }
    });
    // 播放动画
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition( // 透明动画组件
      opacity: _animation, // 执行动画
      child: 
      Image.asset(
        'images/screen.jpeg',
        scale: 2.0, // 缩放
        fit: BoxFit.cover,  // 充满容器
      ),
    );
  }
}
