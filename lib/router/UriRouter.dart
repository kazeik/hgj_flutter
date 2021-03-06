/**
 * 所有的url接口
 */
class UriRouter {
  static Map<String, String> uriRouter;
  static String baseUrl = "http://jfgj.wooyou.org/JFGJ";
  UriRouter();

  initUriRouter() {
    uriRouter = {
      "login": "/signin",
      "producttypesinfo":"/api/productTypeService/producttypesinfo",
      'userservice':"/api/order/user",
      'version':'/open/latestversion',
      'userpass':'/api/user/pwd',
      'modifyctrlpwd':"/api/user/modifyctrlpwd",
      'buildinfo':'/api/v2.0/buildinginfo',
    };
  }
}
