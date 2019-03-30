import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hgj_flutter/beans/UserInfo.dart';
import 'package:hgj_flutter/net/HttpNet.dart';
import 'package:hgj_flutter/pages/HomePage.dart';
import 'package:hgj_flutter/router/UriRouter.dart';
import 'package:hgj_flutter/utils/Utils.dart';
import 'package:hgj_flutter/views/LoadingDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mailController = TextEditingController(text: "123@123.com");
  final passController = TextEditingController(text: "Vonyooyunwei123456");
  bool loading = false;

  /**
   * 构建邮箱
   */
  Widget _buildEmailWidget() {
    var node = new FocusNode();
    return new Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Theme(
        data: new ThemeData(primaryColor: Colors.blue, hintColor: Colors.white),
        child: new TextField(
          onChanged: (str) {},
          style: TextStyle(fontSize: 16.0, color: Colors.white),
          controller: mailController,
          decoration: new InputDecoration(
              hintText: "请输入邮箱",
              hintStyle: TextStyle(color: Colors.white, fontSize: 16.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13.0))),
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          onSubmitted: (text) {
            FocusScope.of(context).reparentIfNeeded(node);
          },
        ),
      ),
    );
  }

  /**
   * 构建密码
   */
  Widget _buildPwdWidget() {
    var node = new FocusNode();
    return new Padding(
        padding: const EdgeInsets.only(left: 40.0, top: 10.0, right: 40.0),
        //改变输入框的外观样式
        child: Theme(
          //未选中时，蓝色 ，选中后白色
          data:
              new ThemeData(primaryColor: Colors.blue, hintColor: Colors.white),
          child: new TextField(
            onChanged: (str) {},
            controller: passController,
            //是否是密码
            obscureText: true,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
            decoration: new InputDecoration(
                hintText: "请输入密码",
                hintStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.0))),
            maxLines: 1,
            keyboardType: TextInputType.text,
            onSubmitted: (text) {
              FocusScope.of(context).reparentIfNeeded(node);
            },
          ),
        ));
  }

  _login(String email, String pwd) async {
    _loading();
    HttpNet.instance.dio.post(UriRouter.uriRouter['login'],
        queryParameters: {"email": email, "pwd": pwd}).then((d) {
      var json = jsonDecode(d.toString());
      List<dynamic> error = json['error'];
      if (error == null || error.isEmpty) {
        var jsondata = json['data'];
        UserInfo info = new UserInfo();
        info.id = jsondata['id'];
        info.nickName = jsondata['nickname'];
        info.name = jsondata['name'];
        info.email = jsondata['email'];
        info.mobile = jsondata['mobile'];
        info.createTime = jsondata['createTime'];
        info.lastLoginTime = jsondata['lastLoginTime'];
        info.status = jsondata['status'];
        info.needpush = jsondata['needpush'];
        info.hasctrlpwd = jsondata['hasctrlpwd'];
        info.hasctrlgesture = jsondata['hasctrlgesture'];
        info.avatar = jsondata['avatar'];
        info.roomids = jsondata['roomids'];

        Utils.mainInfo = info;

        var session = d.headers['set-cookie'];
        for (var item in session) {
          if (item.startsWith("JFGJ_SID=")) {
            var cookie = item.split(";")[0];
            print("cookie = $cookie");
            _saveStringData("cookie", cookie);
            Navigator.pop(context);
            Navigator.of(context).pushReplacementNamed('/home');
          }
        }
      }
    });
  }

  _saveStringData(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  /**
   * 登录按钮
   */
  Widget _buildLoginWidget() {
    return new Padding(
      padding:
          new EdgeInsets.only(left: 40.0, top: 20.0, right: 40.0, bottom: 10.0),
      child: new MaterialButton(
        onPressed:
            (mailController.text.isEmpty || passController.text.length < 8)
                ? null
                : () {
                    _login(mailController.text, passController.text);
                  },
        color: Colors.amberAccent,
        textColor: Colors.white,
        minWidth: 400,
        disabledColor: Colors.blue[100],
        child: new Text(
          "登录",
          style: new TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  void _onRegisterTap() {
    print("注册按钮被响应");
  }

  void _onForgetPassTap() {
    print("忘记密码按钮被响应");
  }

  Widget _buildRegisterAndForgetPass() {
    return new Padding(
        padding: new EdgeInsets.only(left: 40, right: 40),
        child: new Row(
          //子组件的排列方式为主轴两端对齐
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new GestureDetector(
              child: new Text("注册",
                  style: new TextStyle(fontSize: 16.0, color: Colors.white)),
              onTap: _onRegisterTap,
            ),
            new GestureDetector(
              child: new Text(
                "忘记密码",
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              onTap: _onForgetPassTap,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          Container(
            child: Image.asset(Utils.getImgPath('login_bg'),
                fit: BoxFit.fill, alignment: Alignment.center),
          ),
          new Column(
            children: <Widget>[
              Container(
                child: Image.asset(
                  Utils.getImgPath('login_top'),
                ),
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.all(70.0),
              ),
              _buildEmailWidget(),
              _buildPwdWidget(),
              _buildLoginWidget(),
              _buildRegisterAndForgetPass()
            ],
          ),
        ],
      ),
    );
  }

  Widget _loading() {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            //调用对话框
            text: '数据加载中...',
          );
        });
  }
}
