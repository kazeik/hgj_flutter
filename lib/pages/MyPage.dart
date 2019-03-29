

import 'package:flutter/material.dart';

class MyPage extends StatefulWidget{
  State<StatefulWidget> createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("我的"),
        ),
        body: new Center(child: new Text("个人中心")),
      ),
    );
  }
}