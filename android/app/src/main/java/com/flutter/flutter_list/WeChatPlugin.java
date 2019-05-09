package com.flutter.flutter_list;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;
import android.widget.Toast;

import com.flutter.flutter_list.entity.WeiXin;
import com.tencent.mm.opensdk.modelmsg.SendAuth;
import com.tencent.mm.opensdk.modelmsg.SendMessageToWX;
import com.tencent.mm.opensdk.modelmsg.WXImageObject;
import com.tencent.mm.opensdk.modelmsg.WXMediaMessage;
import com.tencent.mm.opensdk.modelmsg.WXWebpageObject;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class WeChatPlugin implements MethodChannel.MethodCallHandler {

    private Activity mActivity;
    //flutter中会将这个CHANNEL以及对应的methodChannel加载的map中，CHANNEL为key，所以要保持和flutter的一致，且与别的CHANNEL区别开，避免被覆盖。
    public final static String CHANNEL = "com.flutter.list/plugin";

    private static WeChatPlugin flutterPlugin;

    private WeChatManager manager;

    private WeChatPlugin(Activity activity) {
        mActivity = activity;
        manager=new WeChatManager();
        if (Constant.wxAPI==null){
            Constant.wxAPI = WXAPIFactory.createWXAPI(activity, Constant.WECHAT_APPID, true);
            Constant.wxAPI.registerApp(Constant.WECHAT_APPID);
        }
    }

    public static WeChatPlugin getInstance() {
        return flutterPlugin;
    }


    public static void registWeChatPlugin(PluginRegistry.Registrar registrar) {
        MethodChannel methodChannel = new MethodChannel(registrar.messenger(), CHANNEL);
        flutterPlugin = new WeChatPlugin(registrar.activity());
        methodChannel.setMethodCallHandler(flutterPlugin);
    }




    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        switch (methodCall.method) {//flutter那边传递的方法名
            case "login":
                manager.setChannelResult(result);
                login();
                break;
            case "shareUrl":
                manager.setChannelResult(result);
                shareUrl(methodCall);
                break;
            case "shareImage":
                manager.setChannelResult(result);
                shareImage(methodCall);
                break;
        }
    }


    //分享图片
    private void shareImage(MethodCall methodCall) {
        Bitmap bmp = BitmapFactory.decodeResource(mActivity.getResources(), R.mipmap.ic_launcher);

//初始化 WXImageObject 和 WXMediaMessage 对象
        WXImageObject imgObj = new WXImageObject(bmp);
        WXMediaMessage msg = new WXMediaMessage();
        msg.mediaObject = imgObj;
        msg.title = methodCall.argument("title");
        msg.description = methodCall.argument("description");

//设置缩略图
        Bitmap thumbBmp = Bitmap.createScaledBitmap(bmp, 48, 48, true);
        bmp.recycle();
        msg.thumbData = Util.bmpToByteArray(thumbBmp, true);

//构造一个Req
        SendMessageToWX.Req req = new SendMessageToWX.Req();
        req.transaction = String.valueOf(System.currentTimeMillis());
        req.message = msg;
        req.scene = SendMessageToWX.Req.WXSceneSession;
//调用api接口，发送数据到微信
        Constant.wxAPI.sendReq(req);
    }

    //分享url   flutter端传递一个map数据，key为title,url,description。 native端进行接收
    private void shareUrl(MethodCall methodCall){
        WXWebpageObject wxWebpageObject = new WXWebpageObject();
        wxWebpageObject.webpageUrl = methodCall.argument("url");
        WXMediaMessage message=new WXMediaMessage(wxWebpageObject);
        message.title=methodCall.argument("title");
        message.description=methodCall.argument("description");
        Bitmap bmp = BitmapFactory.decodeResource(mActivity.getResources(), R.mipmap.ic_launcher);
        message.thumbData = Util.bmpToByteArray(bmp, true);
        //构造一个Req
        SendMessageToWX.Req req = new SendMessageToWX.Req();
        req.transaction = String.valueOf(System.currentTimeMillis());
        req.message = message;
        req.scene = SendMessageToWX.Req.WXSceneSession;
        //调用api接口，发送数据到微信
        Constant.wxAPI.sendReq(req);
    }


    private void login() {
        SendAuth.Req req = new SendAuth.Req();
        req.scope = "snsapi_userinfo";
        req.state = String.valueOf(System.currentTimeMillis());
        Constant.wxAPI.sendReq(req);
    }

    public void onLoginResult(WeiXin weiXin) {
            manager.onReceiveCode(weiXin);
    }

    public void onSharedResult(WeiXin weiXin) {
        manager.onSharedSuccess(weiXin);
    }

}
