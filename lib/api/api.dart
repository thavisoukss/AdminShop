import 'dart:convert';
import 'dart:io';

import 'package:adminshop/model/GetOrderAccept.dart';
import 'package:adminshop/model/Login.dart';
import 'package:adminshop/model/OrderBoardcash.dart';
import 'package:adminshop/model/OrderDetail.dart';
import 'package:adminshop/share/shareConstant.dart';
import 'package:dio/dio.dart';

class apiCall {
  static var dio = new Dio();
  static UserLogin _userlogin = new UserLogin();
  static OrderDetail _orderDetail = new OrderDetail();
  static OrderBoardcast _orderBoardcast = new OrderBoardcast();
  static GetOrderAccept _getOrderAccept = new GetOrderAccept();

  static Future<UserLogin> login(var user, var password, var token) async {
    print('call api');
    var data = {
      "username": user,
      "password": password,
      "usertype": "DISTRIBUTOR",
      "devideToken": token
    };
    print(data);

    try {
      Response response = await dio.post(
        ShareUrl.login,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      _userlogin = UserLogin.fromJson(response.data);
      print(_userlogin.toJson());

      return _userlogin;
    } on DioError catch (e) {
      print(e);
      return _userlogin;
    }
  }

  static Future<OrderBoardcast> getOrderBoardcast(var disID) async {
    print(' start call api getOrderBoardcast ');
    var data = {"DISTRIBUTOR_ID": disID, "STATUS": "NEW"};
    print(data);

    try {
      Response response = await dio.post(
        ShareUrl.getOrderBoardcast,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      _orderBoardcast = OrderBoardcast.fromJson(response.data);
      print(_orderBoardcast.toJson());

      return _orderBoardcast;
    } on DioError catch (e) {
      print(e);
      return _orderBoardcast;
    }
  }

  static Future<OrderDetail> getOrderDetail(var orderNo) async {
    print(' start call api getOrderDetail ');
    var data = {"ORDER_NO": orderNo};
    print(data);

    try {
      Response response = await dio.post(
        ShareUrl.orderDetail,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      _orderDetail = OrderDetail.fromJson(response.data);
      print(_orderDetail.toJson());

      return _orderDetail;
    } on DioError catch (e) {
      print(e);
      return _orderDetail;
    }
  }

  static Future<String> orderAccept(var orderAcceptNo, userName, orderNo,
      shopID, shopName, disID, disName, dateTime, totalAmount) async {
    print(' start call api orderAccept ');
    String res;

    var data = {
      "ORDER_ACCEPT_NO": orderAcceptNo,
      "ACCEPT_USER": userName,
      "ORDER_NO": orderNo,
      "SHOP_ID": shopID,
      "SHOP_NAME": shopName,
      "DISTRIBUTOR_ID": disID,
      "DISTRIBUTOR_NAME": disName,
      "DELIVERLY_DATE_TIME": dateTime,
      "TOTAL_AMOUNT": totalAmount,
      "CCY": "LAK",
      "STATUS": "ACCEPTED"
    };
    print(data);

    try {
      Response response = await dio.post(
        ShareUrl.orderAccept,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      res = response.data['status'];

      return res;
    } on DioError catch (e) {
      print(e);
      return res;
    }
  }

  static Future<GetOrderAccept> getOrderAccept(var orderNo) async {
    print(' start call api Get orderAccept ');

    var data = {"ORDER_NO": orderNo};

    try {
      Response response = await dio.post(
        ShareUrl.getOrderAccept,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      _getOrderAccept = GetOrderAccept.fromJson(response.data);
      return _getOrderAccept;
    } on DioError catch (e) {
      print(e);
      return _getOrderAccept;
    }
  }

  static Future<String> invoidCreate(var invoiceNo, orderNo, orderAcceptNo,
      totalAmount, dateTime, deliveryName, issueName) async {
    print(' start call api Invoice Create ');
    String res;

    var data = {
      "INVOID_NO": invoiceNo,
      "ORDER_NO": orderNo,
      "ORDER_ACCEPT_NO": orderAcceptNo,
      "TOTAL_AMOUNT": totalAmount,
      "CCY": "LAK",
      "DELIVERY_DATE": dateTime,
      "P_DELIVERY_NAME": deliveryName,
      "P_ISSUE_NAME": issueName
    };
    print(data.toString());

    try {
      Response response = await dio.post(
        ShareUrl.invoidCreate,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      res = response.data['status'];

      return res;
    } on DioError catch (e) {
      print(e);
      return res;
    }
  }

  static Future<String> closeOrder(var name, orderNo, remark) async {
    print(' start call api  Close order  ');
    String res;

    var data = {"CLOSE_NAME": name, "ORDER_NO": orderNo, "REMARKS": remark};
    print(data.toString());

    try {
      Response response = await dio.post(
        ShareUrl.closeOrder,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      res = response.data['status'];

      return res;
    } on DioError catch (e) {
      print(e);
      return res;
    }
  }

  static Future<String> deliveryCreate(var deliveryNo, deliveryDatetime,
      deliveryName, orderNo, invoiceNo, issueName, totalAmount) async {
    print(' start call api delivery Create ');
    String res;

    var data = {
      "DELIVERY_NO": deliveryNo,
      "DELIVERY_DATE": deliveryDatetime,
      "DELIVERY_NAME": deliveryName,
      "ORDER_NO": orderNo,
      "INVOID_NO": invoiceNo,
      "ISSUE_NAME": issueName,
      "TOTAL_AMOUNT": totalAmount,
      "CCY": "LAK"
    };
    print(data);
    try {
      Response response = await dio.post(
        ShareUrl.deliveryCreate,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      res = response.data['status'];

      return res;
    } on DioError catch (e) {
      print(e);
      return res;
    }
  }

  static Future<OrderBoardcast> getOrderBoardcastByStatus(
      var disID, var status) async {
    print(' start call api getOrderBoardcast ');
    var data = {"DISTRIBUTOR_ID": disID, "STATUS": status};
    print(data);

    try {
      Response response = await dio.post(
        ShareUrl.getOrderBoardcast,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );
      print(response.data);
      _orderBoardcast = OrderBoardcast.fromJson(response.data);
      print(_orderBoardcast.toJson());

      return _orderBoardcast;
    } on DioError catch (e) {
      print(e);
      return _orderBoardcast;
    }
  }


}
