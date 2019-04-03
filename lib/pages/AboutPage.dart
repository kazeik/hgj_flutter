import 'package:flutter/material.dart';
import 'package:hgj_flutter/utils/Utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

_callPhone() {
  String url = "tel:073182188888";
  launch(url);
}

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  String version = "";

  _onClickEvent(String text) {
    if (text == "系统版本") {
      print("系统版本被响应了");
    } else if (text == "客服电话") {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("提示"),
                content: Text("是否需要拨打电话0731-82188888"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("取消"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("确定"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _callPhone();
                    },
                  )
                ],
              ));
    }
  }

  _getVersion() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String _version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      print("version = $version buildName = $buildNumber");
      setState(() {
        version = _version;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  Widget _buildItemCell(String text, String rightText, double top) {
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
            Text(
              rightText,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("关于我们"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage(Utils.getImgPath("abouttop")),
                      width: 100,
                      height: 100,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "华管家",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                _buildItemCell("系统版本", version, 0),
                _buildItemCell(
                  "客服电话",
                  "0731-82188888",
                  1,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "江西物优网络有限公司\nCopyright c 2016-2017 wooyoo\nAll Rights Reserved.",
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
