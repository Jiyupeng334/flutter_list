import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimTogether extends StatefulWidget {
  @override
  _AnimTogetherState createState() {
    // TODO: implement createState
    return _AnimTogetherState();
  }
}

class _AnimTogetherState extends State<AnimTogether>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;


  @override
  void initState() {
    super.initState();
    //Curves.linear 线性插值器
    controller =
        new AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });
    controller.forward();
  }

  Widget logoScale() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: Container(
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("animation"),
        ),
        body: AnimationLogo(animation: animation));
  }

  @override
  void dispose() {
    controller.dispose(); // TODO: implement dispose
    super.dispose();
  }
}

class AnimationLogo extends AnimatedWidget {
  static final _sizeAnim = new Tween(begin: 0.0, end: 300.0);
  static final _opacityAnim = new Tween(begin: 0.1, end: 1.0);
  static final _colorAnim =
      new ColorTween(begin: Colors.white, end: Colors.black);

  AnimationLogo({
    Key key,
    Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
        child: new Opacity(
      opacity: _opacityAnim.evaluate(animation),
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: _sizeAnim.evaluate(animation),
        width: _sizeAnim.evaluate(animation),
        child: new FlutterLogo(),
        color: _colorAnim.evaluate(animation),
      ),
    ));
  }
}
