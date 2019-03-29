import 'package:flutter/material.dart';
import 'package:hgj_flutter/pages/MonitorPage.dart';
import 'package:hgj_flutter/pages/MyPage.dart';
import 'package:hgj_flutter/pages/ServicePage.dart';
import 'package:hgj_flutter/pages/WarningPage.dart';
import 'package:hgj_flutter/utils/Utils.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentTab = 0;
  var tabImages;
  var pages;

  Image _getTabIcon(int current) {
    if (currentTab == current) {
      return Image(
        image: AssetImage(tabImages[current][1]),
        width: 20,
        height: 20,
      );
    } else {
      return Image(
          width: 20, height: 20, image: AssetImage(tabImages[current][0]));
    }
  }

  var tabs = ['告警', '监控', '服务', '我'];

  Text _getTabTitle(int currentIndex) {
    if (currentTab == currentIndex) {
      return new Text(
        tabs[currentIndex],
        style: new TextStyle(color: const Color(0xff63ca6c)),
      );
    } else {
      return new Text(tabs[currentIndex],
          style: new TextStyle(color: const Color(0xff888888)));
    }
  }

  _initData() {
    tabImages = [
      [Utils.getImgPath('host'), Utils.getImgPath('host_sel')],
      [Utils.getImgPath('monitor'), Utils.getImgPath('monitor_sel')],
      [Utils.getImgPath('service'), Utils.getImgPath('service_sel')],
      [Utils.getImgPath('my'), Utils.getImgPath('my_sel')]
    ];
    pages = [
      new WarningPage(),
      new MonitorPage(),
      new ServicePage(),
      new MyPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    _initData();
    return new Scaffold(
      body: IndexedStack(
        children: <Widget>[
          WarningPage(),
          MonitorPage(),
          ServicePage(),
          MyPage()
        ],
        index: currentTab,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: _getTabIcon(0), title: _getTabTitle(0)),
          BottomNavigationBarItem(icon: _getTabIcon(1), title: _getTabTitle(1)),
          BottomNavigationBarItem(icon: _getTabIcon(2), title: _getTabTitle(2)),
          BottomNavigationBarItem(icon: _getTabIcon(3), title: _getTabTitle(3)),
        ],
        type: BottomNavigationBarType.fixed,
        iconSize: 3.0,
        currentIndex: currentTab,
        onTap: (index) {
          setState(() {
            currentTab = index;
          });
        },
      ),
    );
  }
}
