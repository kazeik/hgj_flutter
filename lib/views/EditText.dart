import 'package:flutter/material.dart';

/**
 * @author kazeik chen
 *         QQ:77132995 email:kazeik@163.com
 *         2019 04 01 14:20
 * 类说明:
 */

class EditText extends StatefulWidget {
  TextEditingController inputControl;
  String hint;
  Color primaryColor;
  Color hintColor;
  Color hintTextColor;
  bool isPass;

  @override
  State<StatefulWidget> createState() => EditTextState(inputControl, hint,
      this.primaryColor, this.hintColor, this.hintTextColor, this.isPass);

  EditText(
      {this.inputControl,
      this.hint,
      this.primaryColor,
      this.hintColor,
      this.hintTextColor,
      this.isPass});
}

class EditTextState extends State<EditText> {
  TextEditingController input;
  String hintText = "";
  Color primaryColor;
  Color hintColor;
  Color hintTextColor;
  bool isPass;
  var node = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: const EdgeInsets.only(left: 40.0, top: 10.0, right: 40.0),
        //改变输入框的外观样式
        child: Theme(
          //未选中时，蓝色 ，选中后白色
          data: new ThemeData(primaryColor: primaryColor, hintColor: hintColor),
          child: new TextField(
            onChanged: (str) {},
            controller: input,
            //是否是密码
            obscureText: isPass,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
            decoration: new InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: hintTextColor, fontSize: 16.0),
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

  EditTextState(this.input, this.hintText, this.primaryColor, this.hintColor,
      this.hintTextColor, this.isPass);
}
