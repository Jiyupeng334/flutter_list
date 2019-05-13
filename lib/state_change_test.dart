import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class StateChangePage extends StatefulWidget{

  @override
  _StateChangeState createState() {
    // TODO: implement createState
    return _StateChangeState();
  }

}


class _StateChangeState extends State<StateChangePage>{

  bool isLoading=true;
  bool isError=false;
  String data;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Widget getBodyWidget(){
    if(isLoading){
      return childWidget();
    }
    if(isError){
      return Center(
        child: InkWell(
          onTap: refreshData,
          child: Text("please click to refresh"),
        ),
      );
    }
    return Center(
      child: InkWell(
        onTap: updateError,
        child: Text(data),
      ),
    );
  }

  void updateError(){
    setState(() {
      isLoading=true;
      isError=false;
    });
    Timer(Duration(seconds: 3), (){
      setState(() {
        isError=true;
        isLoading=false;
      });
    });
  }


  Widget childWidget() {
    Widget childWidget = new Stack(
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
          child: new Center(
            child: SpinKitFadingCircle(
              color: Colors.blueAccent,
              size: 30.0,
            ),
          ),
        ),
        new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
          child: new Center(
            child: new Text("兄台莫急噻~~"),
          ),
        ),
      ],
    );
    return childWidget;
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("stateChange"),),
      body: getBodyWidget(),
    );
  }

  void getData() async{
    Timer(Duration(seconds: 5), (){
      setState(() {
        isLoading=false;
        isError=false;
        data="sss";
      });
    });
  }

  void refreshData() async{
    setState(() {
      isLoading=true;
      isError=false;
    });
    Timer(Duration(seconds: 5), (){
      setState(() {
        isLoading=false;
        isError=false;
        data="sss";
      });
    });
  }

}