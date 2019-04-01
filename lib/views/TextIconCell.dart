import 'package:flutter/material.dart';
import 'package:hgj_flutter/utils/Utils.dart';

class TextIconCell extends StatelessWidget {
  String leftText;
  EdgeInsetsGeometry margin;
  VoidCallback onClick;
  String rightText;
  ImageProvider image;

  TextIconCell(
      {Key key, @required this.leftText, this.margin, this.onClick, this.image})
      : super(key: key);

  Widget _imageright() {
    Container container;
    if (image != null) {
      container = new Container(
        child: Image(
          width: 20,
          height: 20,
          image: image,
        ),
      );
    } else {
      container = new Container();
    }
    return container;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onClick,
      child: Container(
        color: Colors.white,
        margin: this.margin,
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              leftText,
              style: TextStyle(fontSize: 16),
            ),
            _imageright()
          ],
        ),
      ),
    );
  }
}
