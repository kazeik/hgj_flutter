import 'package:flutter/material.dart';

class WarningPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WarningPageState();
}

class WarningPageState extends State<WarningPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("告警"),
        ),
        body: new Center(child: new Text("告警")),
      ),
    );
  }
}
