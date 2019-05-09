package com.flutter.flutter_list;

import android.util.Log;

import com.ansen.http.entity.HttpConfig;
import com.ansen.http.net.HTTPCaller;
import com.ansen.http.net.RequestDataCallback;
import com.flutter.flutter_list.entity.WeiXin;
import com.flutter.flutter_list.entity.WeiXinInfo;
import com.flutter.flutter_list.entity.WeiXinToken;
import com.flutter.flutter_list.wxapi.WXEntryActivity;

import io.flutter.plugin.common.MethodChannel;

public class WeChatManager {


    private MethodChannel.Result channelResult;


    public WeChatManager() {
        //初始化这个okhttp封装类
        HttpConfig httpConfig = new HttpConfig();
        httpConfig.setAgent(true);//有代理的情况能不能访问
        httpConfig.setDebug(true);//是否debug模式 如果是debug模式打印log
        httpConfig.setTagName("ansen");//打印log的tagname
        //初始化HTTPCaller类
        HTTPCaller.getInstance().setHttpConfig(httpConfig);
    }


    public void setChannelResult(MethodChannel.Result result) {
        if (channelResult != null) {
            channelResult.error("www", "anther MethodChannel.Result operation was in progress", null);
        } else {
            this.channelResult = result;
        }
    }


    public void onReceiveCode(WeiXin weiXin) {
        getAccessToken(weiXin.getCode());
    }

    public void getAccessToken(String code) {
        String url = buildAccessTokenUrl(code);
        HTTPCaller.getInstance().get(WeiXinToken.class, url, null, new RequestDataCallback<WeiXinToken>() {
            @Override
            public void dataCallback(WeiXinToken obj) {
                Log.d("ansen", "WeiXinToken ===" + obj.toString());
                if (obj.getErrcode() == 0) {//请求成功
                    getWeiXinUserInfo(obj);
                } else {//请求失败
                    Log.d("ansen", "errormessage=" + obj.getErrmsg());
                    if (channelResult!=null)channelResult.error("error","message:"+obj.getErrmsg(),obj);
                }
            }
        });
    }

    public void getWeiXinUserInfo(WeiXinToken weiXinToken) {
        String url = buildUserInfoUrl(weiXinToken.getAccess_token(),weiXinToken.getOpenid());
        HTTPCaller.getInstance().get(WeiXinInfo.class, url, null, new RequestDataCallback<WeiXinInfo>() {
            @Override
            public void dataCallback(WeiXinInfo obj) {
                if (channelResult != null) {
                    channelResult.success(obj.toMap());
                    channelResult = null;
                }
                Log.i("ansen", "头像地址:" + obj.toString());
            }
        });
    }

    public void onSharedSuccess(WeiXin weiXin) {
        if (channelResult!=null){
            if (weiXin.getErrCode()==0){
                channelResult.success("share success");
            }else {
                channelResult.error("error","errorcode="+weiXin.getErrCode(),weiXin);
            }
            channelResult=null;
        }
    }

    public  String buildAccessTokenUrl(String code){
        return "https://api.weixin.qq.com/sns/oauth2/access_token?" +
                "appid=" + Constant.WECHAT_APPID + "&secret=" + Constant.WECHAT_SECRET +
                "&code=" + code + "&grant_type=authorization_code";
    }

    public String buildUserInfoUrl(String access_token,String openID){
        return "https://api.weixin.qq.com/sns/userinfo?access_token=" +
                access_token + "&openid=" + openID;
    }

}
