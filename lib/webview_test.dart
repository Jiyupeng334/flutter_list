import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class WebviewController {

  Widget index(String url) {
    return new WebviewScaffold(
      url: "http://www.baidu.com",
      withJavascript:true,
      withLocalStorage: true,
      appBar: new AppBar(
        title: new Text("title"),
      ),
    );
  }

}