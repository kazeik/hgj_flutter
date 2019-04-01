import 'package:flutter/material.dart';
import 'package:hgj_flutter/utils/Utils.dart';
import 'package:hgj_flutter/views/TextIconCell.dart';

/**
 * @author kazeik chen
 *         QQ:77132995 email:kazeik@163.com
 *         2019 04 01 11:01
 * 类说明:
 */

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingPageStatus();
}

class SettingPageStatus extends State<SettingPage> {
  bool _value = true;

  _change(bool newState) {
    setState(() {
      _value = newState;
    });
  }

  _onClick(String tag) {
    print("tag = $tag");
    switch (tag) {
      case "changepass":
        break;
      case "controllepass":
        break;
      case "clear":
        break;
      case "update":
        break;
      case "logout":
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    "消息推送",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Switch(
                    value: _value,
                    onChanged: (newStatus) {
                      print("当前状态 $newStatus");
                      _change(newStatus);
                    },
                  ),
                ),
              ],
            ),
          ),
          TextIconCell(
            leftText: "修改登录密码",
            onClick: (){
              _onClick('changepass');
            },
          ),
          TextIconCell(
            leftText: "修改控制密码",
            margin: EdgeInsets.only(top: 1, bottom: 5),
            onClick: (){
              _onClick('controllepass');
            },
          ),
          TextIconCell(
            leftText: "清理缓存",
            margin: EdgeInsets.only(bottom: 5),
            onClick: (){
              _onClick('clear');
            },
          ),
          TextIconCell(
            leftText: "检查更新",
            margin: EdgeInsets.only(bottom: 5),
            onClick: (){
              _onClick('update');
            },
          ),
          GestureDetector(
            onTap: () {
              _onClick("logout");
            },
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              padding: EdgeInsets.all(15),
              child: Text(
                "退出登录",
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
