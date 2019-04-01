import 'package:flutter/material.dart';
import 'package:hgj_flutter/pages/AboutPage.dart';
import 'package:hgj_flutter/pages/HomePage.dart';
import 'package:hgj_flutter/pages/LoginPage.dart';
import 'package:hgj_flutter/pages/MyServicePage.dart';
import 'package:hgj_flutter/pages/SettingPage.dart';
import 'package:hgj_flutter/pages/SplashPage.dart';

/**
 * 路由
 */
class NamedRouter {
  static Map<String, WidgetBuilder> routes;

  static Widget initApp() {
    return MaterialApp(
      routes: NamedRouter.initRoutes(),
      initialRoute: '/',
    );
  }

  static initRoutes() {
    routes = {
      '/': (context) => SplashPage(),
      '/login': (context) => LoginPage(),
      '/home': (context) => HomePage(),
      '/about': (context) => AboutPage(),
      '/myservice': (context) => MyServicePage(),
      '/setting': (context) => SettingPage()
    };
    return routes;
  }
}
