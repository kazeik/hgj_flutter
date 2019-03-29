import 'package:flutter/material.dart';
import 'package:hgj_flutter/pages/AboutPage.dart';
import 'package:hgj_flutter/router/NamedRouter.dart';
import 'package:hgj_flutter/router/UriRouter.dart';
import 'package:hgj_flutter/utils/Utils.dart';

class MyPage extends StatefulWidget {
  State<StatefulWidget> createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  String userName;
  String userLevel;
  String iconPath;

  final List<String> lables = ['我的服务', '操作日志', '设置', '关于', 'user', 'icon'];

  Widget _buildUserInfo() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 5),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _onClickEvent(lables[5]);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: Image(
                  width: 55,
                  height: 55,
                  image: iconPath == null || iconPath == ""
                      ? AssetImage(Utils.getImgPath("host"))
                      : NetworkImage(
                          "${UriRouter.baseUrl}${Utils.mainInfo.avatar}"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _onClickEvent(lables[4]);
              },
              child: Column(
                children: <Widget>[Text(userName), Text(userLevel)],
              ),
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      this.userLevel = Utils.mainInfo.name;
      this.iconPath = Utils.mainInfo.avatar;
      this.userName = Utils.mainInfo.nickName;
    });
  }

  _onClickEvent(String label) {
    if (label == lables[0]) {
      print("我的服务被点击");
    } else if (label == lables[1]) {
      print("操作日志被点击");
    } else if (label == lables[2]) {
      print("设置被点击");
    } else if (label == lables[3]) {
//      Navigator.push(
//          context, new MaterialPageRoute(builder: (context) => AboutPage()));
    Navigator.pushNamed(context, "/about");
    } else if (label == lables[4]) {
      print("个人中心被点击");
    } else if (label == lables[5]) {
      print("头像被点击");
    }
  }

  _buildItemCell(String text, double top) {
    return GestureDetector(
      onTap: () {
        _onClickEvent(text);
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: top, bottom: 1),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
            Image(
              width: 20,
              height: 20,
              image: AssetImage(Utils.getImgPath("host")),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.blue, backgroundColor: Colors.black12),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            title: new Text("我的"),
          ),
          body: Column(
            children: <Widget>[
              _buildUserInfo(),
              _buildItemCell(lables[0], 5),
              _buildItemCell(lables[1], 1),
              _buildItemCell(lables[2], 5),
              _buildItemCell(lables[3], 1),
            ],
          )),
    );
  }
}
