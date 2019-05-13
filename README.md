#主要记录自己学习flutter期间碰到的知识点或者埋坑的情况
各个flutter界面的介绍
1.interact_android主要是针对flutter和android间通信。对应的Android端代码为ReceiveMsgFlutterPlugin.class
2.switchbuton.dart是一个仿ios端switch开关的widget。
3.集成微信登录和微信分享功能.主要涉及到的类有：com.flutter.flutter_list.WeChatManager     com.flutter.flutter_list.WeChatPlugin    Constant等
4.进行flutter的动画练习
5.添加FlutterError.onError = (FlutterErrorDetails details) { reportError(details);};全局的错误拦截统计功能，具体页码在error_test
6.测试版本的回滚。
