import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hgj_flutter/beans/ErrorMsgBean.dart';
import 'package:hgj_flutter/beans/ProdTypeInfoBean.dart';
import 'package:hgj_flutter/beans/ProductDataBean.dart';
import 'package:hgj_flutter/net/HttpNet.dart';
import 'package:hgj_flutter/pages/WebViewPage.dart';
import 'package:hgj_flutter/router/UriRouter.dart';
import 'package:hgj_flutter/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicePage extends StatefulWidget {
  State<StatefulWidget> createState() => ServicePageState();
}

class ServicePageState extends State<ServicePage> {
  bool showToast = false;
  List<ProdTypeInfoBean> allData = new List();

  /**
   * 加载数据
   */
  _loadData(String cookie) {
    HttpNet.instance.dio.options.headers = {
      "Accept": "application/json",
      "user-Agent": "JFGJ",
      "Cookie": cookie
    };

    HttpNet.instance.dio
        .getUri(Uri.parse(UriRouter.uriRouter['producttypesinfo']))
        .then((d) {
      var jsonvalue = jsonDecode(d.toString());
      List<dynamic> temperror = jsonvalue['error'];
      if (null != temperror && temperror.isNotEmpty) {
        ErrorMsgBean msgBean = new ErrorMsgBean();
        msgBean.message = temperror[0]['message'];
        msgBean.field = temperror[0]['field'];

        Utils.showToast(msgBean.message);
        if ((msgBean.field == "403" && msgBean.message == "please reLogin") ||
            msgBean.field == "401")
          Navigator.of(context).pushReplacementNamed('/login');
      } else {
        List<dynamic> dataDynamic = jsonvalue['data'];
        List<ProdTypeInfoBean> typeInfo = new List();
        for (var item in dataDynamic) {
          ProdTypeInfoBean infoBean = new ProdTypeInfoBean();
          infoBean.prodtypeid = item['prodtypeid'];
          infoBean.prodtypename = item['prodtypename'];
          infoBean.prodtypedesc = item['prodtypedesc'];
          infoBean.appicon = item['appicon'];
          infoBean.pcicon = item['pcicon'];
          infoBean.pcimage = item['pcimage'];
          List<dynamic> subList = item['productDataList'];
          infoBean.productDataList = new List();
          for (var dataItem in subList) {
            ProductDataBean dataBean = new ProductDataBean();
            dataBean.prodtypeid = dataItem["prodtypeid"];
            dataBean.prodid = dataItem["prodid"];
            dataBean.prodname = dataItem["prodname"];
            dataBean.subprodids = dataItem["subprodids"];
            dataBean.appicon = dataItem["appicon"];
            dataBean.prodshowpage = dataItem["prodshowpage"];
            infoBean.productDataList.add(dataBean);
          }
          typeInfo.add(infoBean);
        }
        setState(() {
          this.allData = typeInfo;
        });
      }
    });
  }

  _getPreferCookie() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString("cookie");
  }

  @override
  void initState() {
    super.initState();

    _getPreferCookie().then((c) {
      _loadData(c);
    });
  }

  /**
   * 九宫格点击事件
   */
  _gridOnTap(ProductDataBean bean) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new WebViewPage(bean.prodshowpage, bean.prodname)));
  }

  Widget _gridItem(ProductDataBean bean) {
    return Container(
      margin: EdgeInsets.all(3),
      child: GestureDetector(
          onTap: () {
            _gridOnTap(bean);
          },
          child: Column(
            children: <Widget>[
              Image(
                width: 45,
                height: 45,
                image: new NetworkImage("${UriRouter.baseUrl}${bean.appicon}"),
                fit: BoxFit.cover,
              ),
              Text(
                bean.prodname,
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }

  /**
   * 构建listView的子列
   */
  Widget _buildListItem(ProdTypeInfoBean bean) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Colors.black12,
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: new Text(
            bean.prodtypename,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        Container(
          child: GridView.count(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 5 / 3,
              children: bean.productDataList.map((ProductDataBean bean) {
                return _gridItem(bean);
              }).toList()),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: <Widget>[
            //顶部图片
            Image.asset(Utils.getImgPath('top_img')),
//            中间服务类型
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: const Color(0xFFFAEBD7),
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        Image(
                          image: AssetImage(Utils.getImgPath("service_basic")),
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          "基础服务\n免费",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF0F8FF),
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        Image(
                          image: AssetImage(Utils.getImgPath("service_glod")),
                          width: 30,
                          height: 30,
                        ),
                        Text("金牌服务\n尊贵体验")
                      ],
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFF7FFFD4),
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        Image(
                          width: 30,
                          height: 30,
                          image: AssetImage(Utils.getImgPath('service_diman')),
                        ),
                        Text("钻石服务\n专人服务")
                      ],
                    ),
                  ),
                  flex: 1,
                )
              ],
            ),
            //底部的二级列表
            ListView.builder(
                shrinkWrap: true,
                itemCount:
                    (allData == null || allData.isEmpty) ? 0 : allData.length,
                itemBuilder: _buildListItemUi),
          ],
        ),
      ),
    );
  }

  Widget _buildListItemUi(BuildContext context, int index) {
    return _buildListItem(allData[index]);
  }
}
