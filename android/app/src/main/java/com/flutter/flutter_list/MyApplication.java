package com.flutter.flutter_list;

import android.app.Application;
import android.util.Log;

import com.gimbal.android.Communication;
import com.gimbal.android.CommunicationListener;
import com.gimbal.android.CommunicationManager;
import com.gimbal.android.Gimbal;
import com.gimbal.android.Push;

import java.util.Collection;

import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication {

    private CommunicationListener communicationListener;
    private static final String GIMBAL_APP_API_KEY = "c19970d4-0c27-4b76-b8c9-23605277d79d";

    @Override
    public void onCreate() {
        super.onCreate();
        Gimbal.setApiKey(this, GIMBAL_APP_API_KEY);
        Gimbal.enablePushMessaging(true);
        communicationListener = new CommunicationListener() {
            @Override
            public Collection<Communication> presentNotificationForCommunications(Collection<Communication> collection, Push push) {
                Log.d("tag","presentNotificationForCommunications");
                return super.presentNotificationForCommunications(collection, push);
            }

            // override methods as required
        };
        CommunicationManager.getInstance().addListener(communicationListener);
    }
}
