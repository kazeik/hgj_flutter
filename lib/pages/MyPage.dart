import 'package:flutter/material.dart';
import 'package:hgj_flutter/pages/AboutPage.dart';
import 'package:hgj_flutter/router/UriRouter.dart';
import 'package:hgj_flutter/utils/Utils.dart';
import 'package:hgj_flutter/views/TextIconCell.dart';

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
                      ? AssetImage(Utils.getImgPath("logo"))
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
      Navigator.pushNamed(context, "/myservice");
    } else if (label == lables[1]) {
      print("操作日志被点击");
    } else if (label == lables[2]) {
      Navigator.pushNamed(context, "/setting");
    } else if (label == lables[3]) {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => AboutPage()));
    } else if (label == lables[4]) {
      print("个人中心被点击");
    } else if (label == lables[5]) {
      print("头像被点击");
    } else if (label == "test") {
      print("test onClick");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("我的"),
      ),
      body: Column(
        children: <Widget>[
          _buildUserInfo(),
          TextIconCell(
            leftText: lables[0],
            margin: EdgeInsets.only(top: 5),
            image: AssetImage(Utils.getImgPath("arr_right")),
            onClick: () {
              _onClickEvent(lables[0]);
            },
          ),
          TextIconCell(
            leftText: lables[1],
            margin: EdgeInsets.only(top: 1),
            image: AssetImage(Utils.getImgPath("arr_right")),
            onClick: () {
              _onClickEvent(lables[1]);
            },
          ),
          TextIconCell(
            leftText: lables[2],
            margin: EdgeInsets.only(top: 5),
            image: AssetImage(Utils.getImgPath("arr_right")),
            onClick: () {
              _onClickEvent(lables[2]);
            },
          ),
          TextIconCell(
            leftText: lables[3],
            margin: EdgeInsets.only(top: 1),
            image: AssetImage(Utils.getImgPath("arr_right")),
            onClick: () {
              _onClickEvent(lables[3]);
            },
          ),
        ],
      ),
    );
  }
}
