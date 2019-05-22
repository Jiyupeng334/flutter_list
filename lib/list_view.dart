import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget{


  @override
  _ListViewState createState() {
    // TODO: implement createState
    return _ListViewState();
  }

}


class _ListViewState extends State<ListViewPage>{

   var data=List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data.add("111");
    data.add("222");
    data.add("333");
    data.add("444");
    data.add("555");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("listview"),),
      body: ListView.builder(
          itemBuilder: (context,index){ return adapterItem(context, index);},
          itemCount: data.length,
          )
    );
  }

  Widget adapterItem(BuildContext context,int index){
    print("adapterItem");
    Widget item=InkWell(
      onTap: (){
        data[index]="click";
        setState(() {

        });
      },
      child: Text(data[index],style: TextStyle(fontSize: 12),),
    );
    return item;
  }

}