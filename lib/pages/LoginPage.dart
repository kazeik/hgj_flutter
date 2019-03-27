import 'package:flutter/material.dart';
import 'package:hgj_flutter/utils/Utils.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _pwd = "";

  final mailController = TextEditingController();
  final passController = TextEditingController();

  /**
   * 构建邮箱
   */
  Widget _buildEmailWidget() {
    var node = new FocusNode();
    return new Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: Theme(
        data: new ThemeData(primaryColor: Colors.blue,hintColor: Colors.white),
        child: new TextField(
          onChanged: (str) {
            _email = str;
          },
          style: TextStyle(fontSize: 16.0, color: Colors.white),
          controller: mailController,
          decoration: new InputDecoration(
              hintText: "请输入邮箱",
              hintStyle: TextStyle(color: Colors.white, fontSize: 16.0),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(13.0))),
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
            onChanged: (str) {
              _pwd = str;
            },
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

  /**
   * 登录按钮
   */
  Widget _buildLoginWidget() {
    return new Padding(
      padding: new EdgeInsets.only(left:40.0,top: 20.0,right: 40.0,bottom: 10.0),
      child: new MaterialButton(
        onPressed: (_email.isEmpty || _pwd.length < 8) ? null : () {
          print(
              "用户名= $_email 密码= $_pwd mailControler =${mailController.text}  passController = ${passController.text}");
        },
//        onPressed: () {
//          print(
//              "用户名= $_email 密码= $_pwd mailControler =${mailController.text}  passController = ${passController.text}");
//        },
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
        padding: new EdgeInsets.only(left: 40,  right: 40),
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
}
