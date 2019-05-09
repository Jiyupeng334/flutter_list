import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'wechat_manager.dart';

class WeChatLogin extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(title: Text("微信登陆"),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: (){
                //点击进行微信登录
                WeChatManager().login().then((value){

                });
              },
              child: Text("点击进行微信登录"),
            ),
            InkWell(
              onTap: (){
                //点击进行微信图片分享
                WeChatManager().shareImage("url", "title", "desc").then((value){

                });;
                //点击进行微信网址分享
                //WeChatManager().shareUrl("url", "title", "desc").then((value){
                //
                //                });;
              },
              child: Text("点击进行微信分享"),
            )
          ],
        )
      ),
    );
  }

}
