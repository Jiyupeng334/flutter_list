package com.flutter.flutter_list;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    //注册接收flutter调用的Android插件类。
    registReceiveMsgFromFlutter();

  }

  private void registReceiveMsgFromFlutter() {
    ReceiveMsgFlutterPlugin.registReceiveMsgPlugin(this.registrarFor(ReceiveMsgFlutterPlugin.CHANNEL));
  }
}
