/**
 * 所有的url接口
 */
class UriRouter {
  static Map<String, String> uriRouter;

  UriRouter();

  initUriRouter() {
    uriRouter = {
      "login": "/JFGJ/signin",
    };
  }
}
