import 'package:flutter/material.dart';
import 'package:hgj_flutter/router/NamedRouter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NamedRouter.initApp();
  }
}
