import 'package:flutter/material.dart';
import 'package:hgj_flutter/pages/LoginPage.dart';
import 'package:hgj_flutter/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  PageController _pageController = PageController();
  int _pageIndex = 0;

  Widget _createPageController() {
    return PageView(
      controller: _pageController,
      onPageChanged: (pageIndex) {
        setState(() {
          _pageIndex = pageIndex;
        });
      },
      children: <Widget>[
        Container(
            color: Colors.white,
            child: Center(
              child: Image.asset(_guildeList[0]),
            )),
        Container(
            color: Colors.white,
            child: Center(
              child: Image.asset(_guildeList[1]),
            )),
        Container(
            color: Colors.white,
            child: Center(
              child: Image.asset(_guildeList[2]),
            )),
        Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Container(
                  child: Image.asset(_guildeList[3]),
                ),
                Container(
                    //自定义各个方向
                    margin: EdgeInsets.only(bottom: 160.0),
                    alignment: AlignmentDirectional.bottomCenter,
                    child: new RaisedButton(
                        textColor: Colors.white,
                        color: Colors.transparent,
                        child: Text(
                          "立刻开启",
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        onPressed: () {
                          _gotoHomePage();
                        }))
              ],
            )),
      ],
    );
  }

//  @override
//  void initState() {
//    super.initState();
//    _getFristPage();
//  }

  List<String> _guildeList = [
    Utils.getImgPath('splash'),
    Utils.getImgPath('splash1'),
    Utils.getImgPath('splash2'),
    Utils.getImgPath('splash3', format: 'jpg')
  ];

  _gotoHomePage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isFinish", true);
    Navigator.of(context).pushReplacementNamed('/login');
  }

  _getFristPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var value = preferences.getBool("isFinish");
    print("当前是否已加载过 = $value");
    return value;
  }

  Widget _goWitch() {
    if (_getFristPage()) {
      return new Scaffold(
        body: new LoginPage(),
      );
    } else {
      return _createPageController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createPageController(),
    );
  }
}
