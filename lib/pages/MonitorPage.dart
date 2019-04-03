import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hgj_flutter/beans/DeviceRoomItemBean.dart';
import 'package:hgj_flutter/beans/ErrorMsgBean.dart';
import 'package:hgj_flutter/beans/RoomsItemBean.dart';
import 'package:hgj_flutter/net/HttpNet.dart';
import 'package:hgj_flutter/router/UriRouter.dart';
import 'package:hgj_flutter/utils/Utils.dart';
import 'package:dropdown_menu/dropdown_menu.dart';

class MonitorPage extends StatefulWidget {
  State<StatefulWidget> createState() => MonitorPageState();
}

class MonitorPageState extends State<MonitorPage> {
  String titleName = "";
  List<DeviceRoomItemBean> _typeInfo;
  bool hideList = true;

  _onClick(String tag) {
    switch (tag) {
      case "title":
        print("标题响应了");
        setState(() {
          hideList = !hideList;
        });
        break;
    }
  }

  _getbuildinfo() {
    HttpNet.instance.dio.options.headers = {
      "Accept": "application/json",
      "user-Agent": "JFGJ",
      "Cookie": Utils.cookie
    };
    HttpNet.instance.dio
        .getUri(Uri.parse(UriRouter.uriRouter['buildinfo']))
        .then((value) {
      var jsonvalue = jsonDecode(value.toString());
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
        List<DeviceRoomItemBean> typeInfo = new List();
        for (var item in dataDynamic) {
          DeviceRoomItemBean itemBean = new DeviceRoomItemBean();
          itemBean.buildingid = item['buildingid'];
          itemBean.buildingname = item['buildingname'];
          itemBean.rooms = new List();

          List<dynamic> roomslist = item['rooms'];
          for (var roomsItem in roomslist) {
            RoomsItemBean roomsItemBean = new RoomsItemBean();
            roomsItemBean.buildingid = roomsItem['buildingid'];
            roomsItemBean.buildingname = roomsItem['buildingname'];
            roomsItemBean.roomid = roomsItem['roomid'];
            roomsItemBean.roomname = roomsItem['roomname'];
            roomsItemBean.roomalias = roomsItem['roomalias'];
            roomsItemBean.device = roomsItem['device'];
            roomsItemBean.warnCount = roomsItem['warnCount'];
            itemBean.rooms.add(roomsItemBean);
          }

          typeInfo.add(itemBean);
        }

        setState(() {
          this._typeInfo = typeInfo;
          if (_typeInfo != null &&
              _typeInfo.isNotEmpty &&
              _typeInfo[0].rooms != null &&
              _typeInfo[0].rooms.isNotEmpty)
            titleName =
                "${_typeInfo[0].rooms[0].buildingname}-${_typeInfo[0].rooms[0].roomname}";
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getbuildinfo();
  }

  Widget _buildListItem(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(3),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                child: Image(
                  width: 25,
                  height: 25,
                  image: AssetImage(Utils.getImgPath("ic_room", format: 'jpg')),
                ),
              ),
              Text(
                "${_typeInfo[index].rooms[0].buildingname}-${_typeInfo[index].rooms[0].roomname}",
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
        Text(
          "0",
          style: TextStyle(fontSize: 14),
        )
      ],
    );
  }

  Widget _buildList() {
    return Offstage(
      offstage: hideList,
      child: Container(
          margin: EdgeInsets.only(top: 50),
          child: ListView.builder(
              itemCount:
                  _typeInfo == null || _typeInfo.isEmpty ? 0 : _typeInfo.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return _buildListItem(index);
              })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _onClick("title");
              },
              child: Container(
                margin: EdgeInsets.only(top: 25, left: 5),
                child: Text(
                  titleName,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _onClick("alert");
              },
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Image(
                    width: 30,
                    height: 30,
                    image: AssetImage(Utils.getImgPath("ic_warning_normal")),
                  )),
            )
          ],
        ),
        _buildList(),
      ],
    );
  }
}
