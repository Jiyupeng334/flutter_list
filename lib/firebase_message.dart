import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseTest extends StatefulWidget{

  @override
  _FirebaseMessageState createState() {
    // TODO: implement createState
    return _FirebaseMessageState();
  }

}

class _FirebaseMessageState extends State<FirebaseTest>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging().configure(
      onMessage: (Map<String, dynamic> message){
        print("onMessage");
      },
      onLaunch: (Map<String, dynamic> message){
        print("onLaunch");
      },
      onResume: (Map<String, dynamic> message){
        print("onResume");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
      ),
      body: Center(
        child: Text("center"),
      ),
    );
  }

}