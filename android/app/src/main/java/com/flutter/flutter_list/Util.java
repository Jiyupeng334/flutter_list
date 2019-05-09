package com.flutter.flutter_list;

import android.graphics.Bitmap;

import java.io.ByteArrayOutputStream;

public class Util {

    public static byte[] bmpToByteArray(Bitmap thumbBmp, boolean b) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        thumbBmp.compress(Bitmap.CompressFormat.PNG, 100, baos);
        return baos.toByteArray();
    }

}
