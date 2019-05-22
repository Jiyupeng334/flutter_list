import 'package:flutter/material.dart';


// ignore: invalid_override, mixin_class_declares_constructor
class ErrorPage extends StatefulWidget{

  @override
  _ErrorSate createState() {
    // TODO: implement createState
    return _ErrorSate();
  }
}

class _ErrorSate extends State<ErrorPage>{

  String test="出行";

  void reportError(FlutterErrorDetails details) {
    print("two");
    print("detail="+details.toString());
  }

  @override
  void didUpdateWidget(ErrorPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    FlutterError.onError=reportError;
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(title: Text("error page"),),
        body:getBody()
    );
  }

  Widget getBody(){
    Widget contant=null;
    contant= Container(
    margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
    height: 80,
    width: 80,
    color: Colors.black,
    child:new Row(
    children: <Widget>[
    new Container(width: 50,height: 50,color: Colors.red,child: new InkWell(
    child: Text("click me"),
    onTap: (){
      crachApp();
    },
    ),),
    ],
    )
    );

    return  contant;
  }


  void crachApp(){
    List app=List(4);
    app.add(1);
    app.add(2);
    app.add(3);
    app.add(4);
    int a=app[5];
    int c=app[6];
  }

}
