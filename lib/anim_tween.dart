import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';


class FlutterIcon extends StatefulWidget {

  @override
  _FlutterIconState createState() {
    // TODO: implement createState
    return _FlutterIconState();
  }

}
class _FlutterIconState extends State<FlutterIcon> with SingleTickerProviderStateMixin {

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller=new AnimationController(duration: Duration(seconds: 4),vsync: this);
    animation=new Tween(begin: 0.0,end: 200.0).animate(controller)
      ..addStatusListener((status){
        if(status == AnimationStatus.completed){
          controller.reverse(from: 100);
        }else if(status == AnimationStatus.dismissed){
          controller.forward();
        }
      });
    controller.forward();

  }

  Widget logoScale(){
    final size =MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: Container(
        height: animation.value,
        width: animation.value,
        child:  FlutterLogo(),
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("animation"),),
      body:AnimationLogo(animation: animation)
    );
  }
  @override
  void dispose() {
    controller.dispose();// TODO: implement dispose
    super.dispose();
  }

}

class AnimationLogo extends AnimatedWidget{

  AnimationLogo({Key key,Animation<double> animation,}):super(key:key,listenable:animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }

}