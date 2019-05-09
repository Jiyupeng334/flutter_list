import 'package:flutter/services.dart';


const String CHANNEL="com.flutter.list/plugin";//定义的通道
const playform=const MethodChannel(CHANNEL);

class  WeChatManager{

  Future<Object> login() async{
    var result;
    try{
      result = await playform.invokeMethod("login");
    }on PlatformException catch(e){
      result=e.message;
    }
      return result;
  }

  Future<String> shareUrl(String url,String title,String desc) async{
    Map<String,String> map={
      "title":title,
      "url":url,
      "description":desc
    };
    String result = await playform.invokeMethod("shareUrl",map);
    return result;
  }

  Future<String> shareImage(String url,String title,String desc) async{
    Map<String,String> map={
      "title":title,
      "url":url,
      "description":desc
    };
    String result = await playform.invokeMethod("shareUrl",map);
    return result;
  }



}