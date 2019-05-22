
import 'package:sharesdk/sharesdk.dart';


class ShareManager{

  void shareImage(String title,String description,String imageURL){
    SSDKMap map=SSDKMap()..setGeneral(title, description, [imageURL], imageURL, imageURL, null, null, null, null, SSDKContentTypes.image);
    ShareSDK.share(ShareSDKPlatforms.facebook, map, (SSDKResponseState state, Map userdata, Map contentEntity, SSDKError error){
      print("shareImage");
    });
  }

  void shareURL(String title,String description,String shareURL){
    SSDKMap map=SSDKMap()..setGeneral(title, description, "http://pic.58pic.com/58pic/15/68/59/71X58PICNjx_1024.jpg", "http://pic.58pic.com/58pic/15/68/59/71X58PICNjx_1024.jpg", null, shareURL, null, null, null, SSDKContentTypes.webpage);
    ShareSDK.share(ShareSDKPlatforms.facebook, map, (SSDKResponseState state, Map userdata, Map contentEntity, SSDKError error){
      print("shareURL");
    });
  }

  void shareText(String title,String description){
    SSDKMap map=SSDKMap()..setGeneral(title, description, null, null, null, null, null, null, null, SSDKContentTypes.text);
    ShareSDK.share(ShareSDKPlatforms.facebook, map, (SSDKResponseState state, Map userdata, Map contentEntity, SSDKError error){
      print("shareText");
    });
  }

}