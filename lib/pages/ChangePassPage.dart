import 'package:flutter/material.dart';
import 'package:hgj_flutter/net/HttpNet.dart';
import 'package:hgj_flutter/router/UriRouter.dart';
import 'package:hgj_flutter/utils/Utils.dart';
import 'package:hgj_flutter/views/EditText.dart';

/**
 * @author kazeik chen
 *         QQ:77132995 email:kazeik@163.com
 *         2019 04 01 14:17
 * 类说明:
 */

class ChangePassPage extends StatefulWidget {
  bool user;

  @override
  State<StatefulWidget> createState() => ChangePageState(isUser: user);

  ChangePassPage({this.user});
}

class ChangePageState extends State<ChangePassPage> {
  TextEditingController oldController = new TextEditingController();
  TextEditingController newController = new TextEditingController();
  TextEditingController subController = new TextEditingController();
  bool isUser;

  ChangePageState({this.isUser});

  _submit(String pwd, String newpwd) {
    Utils.loading(context, text: "加载中");
    if(isUser) {
      HttpNet.instance.dio.post(UriRouter.uriRouter['userpass'],
          queryParameters: {"pwd": pwd, "newpwd": newpwd}).then((value) {});
    }else{
      HttpNet.instance.dio.post(UriRouter.uriRouter['modifyctrlpwd'],
          queryParameters: {"pwd": pwd, "newpwd": newpwd}).then((value) {});
    }
  }

  Widget _buildSubmitWidget() {
    return new Padding(
      padding:
          new EdgeInsets.only(left: 40.0, top: 20.0, right: 40.0, bottom: 10.0),
      child: new MaterialButton(
        onPressed: (oldController.text.isEmpty ||
                newController.text.length < 8 ||
                subController.text.length < 8)
            ? null
            : () {
                _submit(oldController.text, newController.text);
              },
        color: Colors.blue,
        textColor: Colors.white,
        minWidth: 400,
        disabledColor: Colors.blue[100],
        child: new Text(
          "提交",
          style: new TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUser ? "修改登录密码" : "修改控制密码"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          EditText(
            inputControl: oldController,
            hint: "请输入原密码",
            primaryColor: Colors.blue,
            hintColor: Colors.grey,
            hintTextColor: Colors.black,
            isPass: true,
          ),
          EditText(
            inputControl: newController,
            hint: "请输入新密码",
            primaryColor: Colors.blue,
            hintColor: Colors.grey,
            hintTextColor: Colors.black,
            isPass: true,
          ),
          EditText(
            inputControl: subController,
            hint: "请重复输入新密码",
            primaryColor: Colors.blue,
            hintColor: Colors.grey,
            hintTextColor: Colors.black,
            isPass: true,
          ),
          _buildSubmitWidget()
        ],
      ),
    );
  }
}
