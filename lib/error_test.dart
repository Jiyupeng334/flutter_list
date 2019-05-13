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
    contant=Container(
        margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        height: 200,
        width: 200,
        color: Colors.black,
        child:new Row(
          children: <Widget>[
            new Container(width: 50,height: 50,color: Colors.red,child: new InkWell(
              child: Text("click me"),
              onTap: (){
                throw FormatException("test error");
              },
            ),),
            new Container(width: 50,height: 50,color: Colors.yellow,child: InkWell(
              onTap:(){
                throw Exception;
              },
              child: Text(test),
            ),),
            new Container(width: 50,height: 50,color: Colors.green,),
          ],
        )
    );

    return  contant;
  }

}
