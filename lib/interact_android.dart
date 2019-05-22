import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'error_test.dart';
//此文件为flutter与android交互代码

 const  String CHANNEL="com.flutter.list/plugin";//定义的通道
 const  playform=const MethodChannel(CHANNEL);


class Interact extends StatefulWidget{
  @override
  _InteractState createState() {
    return _InteractState();
  }
}


class _InteractState extends State<Interact>{

  String result1=null;
  String result2=null;
  String result3=null;

  @override
  void initState() {
    super.initState();
  }

  _sendMSGtoToast() async{
      String result =await playform.invokeMethod("toast");
      this.setState((){
        result1=result;
      });
  }

  _sendArgumtoAndroid() async{
    Map<String,String> map= { "flutter": "这是一条来自flutter的参数" };
    String result =await playform.invokeMethod("getAragums",map);
    this.setState((){
      result2=result;
    });
  }

  _sendArgumtAndJump() async{
    String result =await playform.invokeMethod("jump","jump activity");
    this.setState((){
      result3=result;
    });
  }

  _getPackageInfo() async{
    await playform.invokeMethod("package").then((dynamic result){
      String versionCode=result["versionCode"];
      String versionName=result["versionName"];
      String packageName=result["packageName"];
      print(versionCode.toString()+","+versionName.toString()+","+packageName.toString());
    });
  }
  _loadUrl() async{
    String result =await playform.invokeMethod("loadURL","https://tinderevents.onelink.me/cy2U/19da1010");
    print("result="+result);
  }

  void _router(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> new ErrorPage()));
  }


  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("与android交互界面"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            RaisedButton(onPressed: _sendMSGtoToast,child: Text("点击调用Android toast")),
            RaisedButton(onPressed: _sendArgumtoAndroid,child: Text("点击向Android端发送数据"),),
            RaisedButton(onPressed: _sendArgumtAndJump,child: Text("点击发送数据并进行Android界面跳转"),),
            RaisedButton(onPressed: _getPackageInfo,child: Text("获取版本号"),),
            RaisedButton(onPressed: _loadUrl,child: Text("跳转浏览器"),),
            RaisedButton(onPressed: _router,child: Text("跳转界面"),)
          ],
        ),
      )
      );
  }
  
}