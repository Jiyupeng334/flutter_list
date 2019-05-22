import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sharesdk/sharesdk.dart';
import 'share_util.dart';

class DpTest extends StatelessWidget{

  GlobalKey globalKey=GlobalKey();

  getWH(){
    double w=globalKey.currentContext.size.width;
    double h=globalKey.currentContext.size.height;
    print("w="+w.toString()+"--h="+h.toString());
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(title: Text("dptrans"),),
      body: new Container(
        alignment: Alignment.center,
        child: InkWell(
          key: globalKey,
          onTap: (){
            getWH();
          },
          child: new Text(
            "event_name",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.69),
          ),
        )
      ),
    );
  }


}