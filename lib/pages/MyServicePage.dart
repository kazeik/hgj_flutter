import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hgj_flutter/beans/ErrorMsgBean.dart';
import 'package:hgj_flutter/beans/OrderListBean.dart';
import 'package:hgj_flutter/net/HttpNet.dart';
import 'package:hgj_flutter/router/UriRouter.dart';
import 'package:hgj_flutter/utils/Utils.dart';

/**
 * 我的服务
 */
class MyServicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyServiceState();
}

class MyServiceState extends State<MyServicePage> {
  List<OrderListBean> allData;

  _getListData() {
    HttpNet.instance.dio.get(UriRouter.uriRouter['userservice']).then((data) {
      var datajson = jsonDecode(data.toString());
      List<dynamic> errors = datajson['error'];
      if (errors != null && errors.isNotEmpty) {
        ErrorMsgBean msgBean = new ErrorMsgBean();
        msgBean.message = datajson[0]['message'];
        msgBean.field = datajson[0]['field'];
        Utils.showToast(msgBean.message);
        return;
      }
      var dataobj = datajson['data'];
      List<dynamic> listdata = dataobj['list'];
      if (listdata == null || listdata.isEmpty) return;
      List<OrderListBean> tempData = new List();
      for (var item in listdata) {
        OrderListBean bean = new OrderListBean();
        bean.orderid = item['orderid'];
        bean.userid = item['userid'];
        bean.prodid = item['prodid'];
        bean.showid = item['showid'];
        bean.paymode = item['paymode'];
        bean.paystub = item['paystub'];
        bean.payprice = item['payprice'];
        bean.status = item['status'];
        bean.address = item['address'];
        bean.phonenum = item['phonenum'];
        bean.name = item['name'];
        bean.email = item['email'];
        bean.time = item['time'];
        bean.prodname = item['prodname'];
        bean.appicon = item['appicon'];
        bean.statustext = item['statustext'];
        tempData.add(bean);
      }
      setState(() {
        this.allData = tempData;
      });
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(5),
            child: Image(
              width: 45,
              height: 45,
              image:
              NetworkImage("${UriRouter.baseUrl}${allData[index].appicon}"),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(allData[index].prodname),
              Text(allData[index].time)
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(allData[index].statustext),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的服务"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: _buildListItem,
        itemCount: (allData == null || allData.isEmpty) ? 0 : allData.length,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getListData();
  }
}
