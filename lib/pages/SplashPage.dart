import 'package:flutter/material.dart';
import 'package:hgj_flutter/pages/LoginPage.dart';
import 'package:hgj_flutter/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SplashPageState();
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

  @override
  void initState() {
    super.initState();
    _getFristPage().then((bool b) {
      if (b != null && b) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

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

  Future<bool> _getFristPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool("isFinish");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createPageController(),
    );
  }
}
