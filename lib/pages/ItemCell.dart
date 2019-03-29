import 'package:flutter/material.dart';
import 'package:hgj_flutter/utils/Utils.dart';

class ItemCell extends StatelessWidget {
  String text;
  double top;
  GestureDetector onTap;

  ItemCell(this.text, this.top, this.onTap);

  _onClick(String tag) {
    onTap;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("点击事件");
        _onClick(text);
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: top, bottom: 1),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
            Image(
              width: 20,
              height: 20,
              image: AssetImage(Utils.getImgPath("host")),
            )
          ],
        ),
      ),
    );
  }
}
