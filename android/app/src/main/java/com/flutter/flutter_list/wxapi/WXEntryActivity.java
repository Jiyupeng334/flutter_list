package com.flutter.flutter_list.wxapi;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;

import com.flutter.flutter_list.Constant;
import com.flutter.flutter_list.R;
import com.flutter.flutter_list.WeChatPlugin;
import com.flutter.flutter_list.entity.WeiXin;
import com.tencent.mm.opensdk.constants.ConstantsAPI;
import com.tencent.mm.opensdk.modelbase.BaseReq;
import com.tencent.mm.opensdk.modelbase.BaseResp;
import com.tencent.mm.opensdk.modelmsg.SendAuth;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.IWXAPIEventHandler;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import io.flutter.app.FlutterActivity;

public class WXEntryActivity extends FlutterActivity implements IWXAPIEventHandler {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_wxentry);
        if (Constant.wxAPI==null){
            Constant.wxAPI = WXAPIFactory.createWXAPI(this, Constant.WECHAT_APPID, true);
            Constant.wxAPI.registerApp(Constant.WECHAT_APPID);
        }
        Constant.wxAPI.handleIntent(getIntent(), this);
    }

    @Override
    protected void onNewIntent(Intent intent){
        super.onNewIntent(intent);
        Constant.wxAPI.handleIntent(getIntent(),this);
        Log.i("ansen","WXEntryActivity onNewIntent");
    }

    @Override
    public void onReq(BaseReq arg0) {
        Log.i("ansen","WXEntryActivity onReq:"+arg0);
    }

    @Override
    public void onResp(BaseResp resp){
        if(resp.getType()== ConstantsAPI.COMMAND_SENDMESSAGE_TO_WX){//分享
            Log.i("ansen","微信分享操作.....");
            WeiXin weiXin=new WeiXin(2,resp.errCode,"",resp.errStr);
            WeChatPlugin.getInstance().onSharedResult(weiXin);
        }else if(resp.getType()==ConstantsAPI.COMMAND_SENDAUTH){//登陆
            Log.i("ansen", "微信登录操作.....");
            SendAuth.Resp authResp = (SendAuth.Resp) resp;
            WeiXin weiXin=new WeiXin(1,resp.errCode,authResp.code,resp.errStr);
            WeChatPlugin.getInstance().onLoginResult(weiXin);
            //EventBus.getDefault().post(weiXin);
        }
        finish();
    }

}
