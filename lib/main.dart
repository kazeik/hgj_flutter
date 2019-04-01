import 'package:flutter/material.dart';
import 'package:hgj_flutter/router/NamedRouter.dart';
import 'package:hgj_flutter/router/UriRouter.dart';
import 'package:hgj_flutter/views/LoadingDialog.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    new UriRouter().initUriRouter();
    return NamedRouter.initApp();
  }
}
