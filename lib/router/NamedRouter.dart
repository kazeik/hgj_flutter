import 'package:flutter/material.dart';
import 'package:hgj_flutter/pages/LoginPage.dart';
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
      '/login': (context) => LoginPage()
    };
    return routes;
  }
}
