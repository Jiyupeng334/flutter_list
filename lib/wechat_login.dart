import 'package:flutter/material.dart';


class WeChatLogin extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(title: Text("微信登陆"),
        centerTitle: true,
      ),
      body: Center(
        child: InkWell(
          onTap: (){
            //点击进行微信登录

          },
          child: Text("点击进行微信登录"),
        ),
      ),
    );
  }

}
