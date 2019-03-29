import 'package:flutter/material.dart';
import 'package:hgj_flutter/utils/Utils.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.blue, backgroundColor: Colors.black12),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            );
          }),
          centerTitle: true,
          title: Text("关于我们"),
        ),
        body: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(30),
                child: Image(image: AssetImage(Utils.getImgPath("login_top")))),
          ],
        ),
      ),
    );
  }
}
