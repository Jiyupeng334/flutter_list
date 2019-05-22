package com.flutter.flutter_list;

import android.Manifest;
import android.app.DownloadManager;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.util.Log;
import android.widget.Toast;

import com.ansen.http.net.HTTPCaller;
import com.ansen.http.net.RequestDataCallback;
import com.flutter.flutter_list.entity.WeiXin;
import com.flutter.flutter_list.entity.WeiXinInfo;
import com.flutter.flutter_list.entity.WeiXinToken;
import com.flutter.flutter_list.wxapi.WXEntryActivity;
import com.gimbal.android.Gimbal;
import com.tencent.mm.opensdk.constants.ConstantsAPI;
import com.tencent.mm.opensdk.modelmsg.SendAuth;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  public static final int LOCATION_PERMISSION_REQUEST_CODE = 101;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    //注册接收flutter调用的Android插件类。
    //initWeChat();
    registFlutterPlugin();
    requestPermission();
  }

  private void requestPermission() {
    if(ContextCompat.checkSelfPermission(MainActivity.this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED){
      ActivityCompat.requestPermissions(MainActivity.this,new String[]{Manifest.permission.ACCESS_FINE_LOCATION},LOCATION_PERMISSION_REQUEST_CODE);        }
    else{
      Gimbal.start();
      Toast.makeText(MainActivity.this,"已开启定位权限",Toast.LENGTH_LONG).show();
    }
  }

  private void initWeChat() {
    Constant.wxAPI = WXAPIFactory.createWXAPI(this, Constant.WECHAT_APPID, true);
    Constant.wxAPI.registerApp(Constant.WECHAT_APPID);

  }

  private void registFlutterPlugin() {
    //初始化测试fluttr和android通信的插件
    ReceiveMsgFlutterPlugin.registReceiveMsgPlugin(this.registrarFor(ReceiveMsgFlutterPlugin.CHANNEL));
    //初始化微信登录和分享的插件
    //WeChatPlugin.registWeChatPlugin(this.registrarFor(ReceiveMsgFlutterPlugin.CHANNEL));
  }

  @Override
  public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
    if (requestCode == LOCATION_PERMISSION_REQUEST_CODE) {
      if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
        Gimbal.start();
      }
    }
  }

}
