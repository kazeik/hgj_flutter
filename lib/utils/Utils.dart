import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hgj_flutter/beans/UserInfo.dart';
import 'package:hgj_flutter/views/LoadingDialog.dart';

class Utils {
  static UserInfo mainInfo;

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget loading(BuildContext context, {String text}) {
    String _text = '数据加载中...';
    if (text != null && text != "") {
      _text = text;
    }
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext _context) {
          return new LoadingDialog(
            //调用对话框
            text: _text,
          );
        });
  }
}
