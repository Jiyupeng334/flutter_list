package com.flutter.flutter_list;

/*响应flutter的调用的插件化代码*/

import android.app.Activity;
import android.app.IntentService;
import android.content.Intent;
import android.content.pm.ComponentInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.util.Log;
import android.widget.Toast;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class ReceiveMsgFlutterPlugin implements MethodChannel.MethodCallHandler {

    private Activity mActivity;
    //flutter中会将这个CHANNEL以及对应的methodChannel加载的map中，CHANNEL为key，所以要保持和flutter的一致，且与别的CHANNEL区别开，避免被覆盖。
    public final static String CHANNEL="com.flutter.list/plugin";

    private ReceiveMsgFlutterPlugin(Activity activity){
        mActivity=activity;
    }

    public static void registReceiveMsgPlugin(PluginRegistry.Registrar registrar){
        MethodChannel methodChannel=new MethodChannel(registrar.messenger(),CHANNEL);
        ReceiveMsgFlutterPlugin plugin=new ReceiveMsgFlutterPlugin(registrar.activity());
        methodChannel.setMethodCallHandler(plugin);
    }


    @java.lang.Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
            switch (methodCall.method){//flutter那边传递的方法名
                case "toast":
                    Toast.makeText(mActivity,"receive message",Toast.LENGTH_LONG).show();
                    result.success("toast--success");//返回flutter的值
                    break;
                case "getAragums":
                    //methodCall.arguments()方法返回flutter那边传入的object类型的参数
                    //methodCall.argument(key)方法会判断传入的参数是否为map，如果是，会返回key对应的value。具体见源码。
                    Map<String,String> map=methodCall.arguments();
                    String str=map.get("flutter");
                    //或者这样获取参数   methodCall.argument("flutter");
                    Toast.makeText(mActivity,"receive message"+str,Toast.LENGTH_LONG).show();
                    result.success("getAragums--success");//返回flutter的值
                    break;
                case "jump":
                    String argu=methodCall.arguments.toString();
                    Intent intent=new Intent(mActivity,TestActivity.class);
                    intent.putExtra("test",argu);
                    mActivity.startActivity(intent);
                    result.success("jump success");
                    break;
                case "package":
                    Map<String,String> packageMap=new LinkedHashMap<>();
                    PackageManager manager=mActivity.getPackageManager();
                    try {
                        PackageInfo info=manager.getPackageInfo(mActivity.getPackageName(),0);
                        packageMap.put("versionCode",info.versionCode+"");
                        packageMap.put("versionName",info.versionName);
                        packageMap.put("packageName",info.packageName);
                    } catch (PackageManager.NameNotFoundException e) {
                        e.printStackTrace();
                    }
                    result.success(packageMap);
                    break;
            }
    }
}
