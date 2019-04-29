import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


/*搭建一个类似ios上的switch开关*/

class SwitchButton extends StatefulWidget{
  @override
  _SwitchButtonState createState() {
    return _SwitchButtonState();
  }


}

class _SwitchButtonState extends State<SwitchButton>{

  //默认为关闭状态，项目中可以自己去控制
  bool switchValue=false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //画一个灰色的背景，背景的左侧是一个绿色的小圆，具体为什么大家可以去掉试试就知道了。
    Widget switchBackground = Container(
      width: 50,
      height: 30,
      child: Row(
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              //color: Color.fromRGBO(142, 142, 147, 1),
              color: Color(0xFF4CD964),
              borderRadius: BorderRadius.circular(11.0),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(142, 142, 147, 1),
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
    return new Scaffold(
      appBar: AppBar(title: Text("搭建一个类似ios上的switch开关"),),
      body: Center(
        child:  Stack(
          alignment: Alignment.center,
          children: <Widget>[
            switchBackground,
            CupertinoSwitch(
              value: switchValue,
              onChanged: (value) {
                setState(() {
                  switchValue=value;
                });
              },
            )
          ],
        ),
      ),
      );
  }

}
