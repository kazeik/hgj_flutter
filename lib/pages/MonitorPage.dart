import 'package:flutter/material.dart';

class MonitorPage extends StatefulWidget {
  State<StatefulWidget> createState() => MonitorPageState();
}

class MonitorPageState extends State<MonitorPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("监控"),
      ),
      body: new Center(child: new Text("监控")),
    );
  }
}
