import 'package:dio/dio.dart';
import 'package:hgj_flutter/router/UriRouter.dart';

class HttpNet {
  // 工厂模式
  factory HttpNet() => _getInstance();

  Dio dio;

  static HttpNet get instance => _getInstance();
  static HttpNet _instance;

  //初始化
  HttpNet._internal() {
    _initDio();
  }

  static HttpNet _getInstance() {
    if (_instance == null) {
      _instance = new HttpNet._internal();
    }
    return _instance;
  }

  _initDio() {
    dio = new Dio();
    dio.options.connectTimeout = 15 * 1000;
    dio.options.receiveTimeout = 15 * 1000;
    dio.options.baseUrl = UriRouter.baseUrl;
    dio.interceptors.add(LogInterceptor(responseBody: true)); //开启请求日志
  }
}
