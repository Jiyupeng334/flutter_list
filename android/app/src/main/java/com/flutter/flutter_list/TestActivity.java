package com.flutter.flutter_list;

import android.os.Bundle;
import android.os.PersistableBundle;
import android.widget.TextView;

import io.flutter.app.FlutterActivity;

public class TestActivity extends FlutterActivity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_test);
        TextView tv=findViewById(R.id.tv);
        String str=getIntent().getStringExtra("test");
        tv.setText("传递来的参数为"+str);
    }
}
