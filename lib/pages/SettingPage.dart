import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hgj_flutter/beans/ErrorMsgBean.dart';
import 'package:hgj_flutter/beans/VersionBean.dart';
import 'package:hgj_flutter/net/HttpNet.dart';
import 'package:hgj_flutter/pages/ChangePassPage.dart';
import 'package:hgj_flutter/router/UriRouter.dart';
import 'package:hgj_flutter/utils/Utils.dart';
import 'package:hgj_flutter/views/TextIconCell.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int versionNumber = 0;

  _change(bool newState) {
    setState(() {
      _value = newState;
    });
  }

  _checkversion() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String buildNumber = packageInfo.buildNumber;
      setState(() {
        this.versionNumber = int.parse(buildNumber);
      });

      HttpNet.instance.dio.get(UriRouter.uriRouter['version'],
          queryParameters: {"type": "0"}).then((value) {
        var datajson = jsonDecode(value.toString());
        List<dynamic> errors = datajson['error'];
        if (errors != null && errors.isNotEmpty) {
          ErrorMsgBean msgBean = new ErrorMsgBean();
          msgBean.message = datajson[0]['message'];
          msgBean.field = datajson[0]['field'];
          Utils.showToast(msgBean.message);
          return;
        }
        var dataobj = datajson['data'];
        VersionBean bean = new VersionBean();
        bean.versionNo = dataobj['versionNo'];
        bean.version = dataobj['version'];
        bean.updateMemo = dataobj['updateMemo'];
        bean.updateTime = dataobj['updateTime'];
        bean.fileUrl = dataobj['fileUrl'];
        bean.devType = dataobj['devType'];
        bean.force_update = dataobj['force_update'];

        if (bean.versionNo > versionNumber) {
          Utils.showToast("版本有更新");
        }
      });
    });
  }

  _onClick(String tag) {
    switch (tag) {
      case "changepass":
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return ChangePassPage(user: true);
        }));
        break;
      case "controllepass":
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return ChangePassPage(user: false);
        }));
        break;
      case "update":
        _checkversion();
        break;
      case "logout":
        _exit();
        break;
    }
  }

  _exit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("cookie");
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed("/login");
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
            onClick: () {
              _onClick('changepass');
            },
          ),
          TextIconCell(
            leftText: "修改控制密码",
            margin: EdgeInsets.only(top: 1, bottom: 5),
            onClick: () {
              _onClick('controllepass');
            },
          ),
          TextIconCell(
            leftText: "检查更新",
            margin: EdgeInsets.only(bottom: 5),
            onClick: () {
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
