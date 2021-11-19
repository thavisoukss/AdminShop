import 'package:adminshop/share/dialog.dart';
import 'package:adminshop/share/saveUser.dart';
import 'package:flutter/material.dart';
import 'package:adminshop/model/OrderDetail.dart' as detail;
import 'package:adminshop/api/api.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart'; //for date format

class OrderDetail extends StatefulWidget {
  final String OrderNo;
  final int ShopID;
  final String ShopName;
  final int DistID;
  final String DistName;

  OrderDetail(
      {Key key,
      this.OrderNo,
      this.ShopID,
      this.ShopName,
      this.DistID,
      this.DistName})
      : super(key: key);

  @override
  _OrderDetailState createState() =>
      _OrderDetailState(OrderNo, ShopID, ShopName, DistID, DistName);
}

class _OrderDetailState extends State<OrderDetail> {
  String _orderNo;
  int _shopID;
  String _shopName;
  int _distID;
  String _distName;

  _OrderDetailState(this._orderNo, this._shopID, this._shopName, this._distID,
      this._distName);

  detail.OrderDetail orderDetail = null;
  int total;
  String userName;

  final format_currency = new NumberFormat("#,##0.00", "en_US");

  List<detail.Data> _listOrder = new List<detail.Data>();
  detail.Data res = new detail.Data();

  Future _orderDetail() async {
    apiCall.getOrderDetail(_orderNo).then((value) {
      setState(() {
        orderDetail = value;
        _listOrder = orderDetail.data;
        total = orderDetail.total;

        // total = orderDetail.data[0].sUMSUBTOTAL.double();
        //     .map<double>((m) => double.parse(m.sUMSUBTOTAL.toString()))
        //     .reduce((a, b) => a + b);
        print('Total' + total.toString());
      });
    });
  }

  Future _getUser() async {
    getUser(shareName: "username").then((value) {
      setState(() {
        userName = value;
        print('userName is :' + userName);
      });
    });
  }

  Future<String> formatdate() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('ddMMyyyyhhmm');
    String formatted = formatter.format(now);

    String order_ID = "AC" + formatted;
    return order_ID;
  }

  Future accepOrder() async {
    String orderAcceptNo = await formatdate();

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
    String formatted = formatter.format(now);
    String response;

    response = await apiCall.orderAccept(orderAcceptNo, userName, _orderNo,
        _shopID, _shopName, _distID, _distName, formatted, total);

    if (response == 'success') {
      showSuccessMessage(context, 'ຍອມຮັບລາຍການສຳເລັດ');
    } else {
      showErrorMessage(context, 'ຍອມຮັບລາຍການບໍ່ສຳເລັດ');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getUser();
    _orderDetail();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລາຍລະອຽດເຄື່ອງ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [_allOrderDetail(), order()],
        ),
      ),
    );
  }

  Widget _heaerOrder() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Icon(
                    Icons.add_shopping_cart_rounded,
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    child: Text(
                      'ລາຍການສັ່ງທັງໝົດ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                  child: Divider(
                thickness: 1.0,
                color: Colors.blue,
              )),
            )
          ],
        ),
      ),
    );
  }

  Widget _listDetail() {
    return orderDetail == null
        ? Container()
        : Container(
            height: 300,
            child: ListView.builder(
              itemCount: _listOrder.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _detail(_listOrder[index], index + 1),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          );
  }

  Widget _detail(detail.Data inData, var index) {
    return orderDetail == null
        ? Container()
        : Container(
            height: 40,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(index.toString()),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Text(
                                inData.iTEMNAME,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              format_currency.format(inData.pRICE).toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                inData.aMOUNT.toString(),
                                style: TextStyle(
                                    color: Color(0xff09b83e),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              format_currency
                                  .format(inData.sUBTOTAL)
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget _total() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: orderDetail == null
          ? Container()
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'ລວມທັງໝົດ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: _orderDetail == null
                                ? Container(
                                    child: Text(''),
                                  )
                                : Text(
                                    format_currency
                                        .format(orderDetail.total)
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'ລວມທັງໝົດທີ່ຕ້ອງຈ່າຍ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: _orderDetail == null
                              ? Container(
                                  child: Text(''),
                                )
                              : Text(
                                  format_currency
                                      .format(orderDetail.total)
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _allOrderDetail() {
    return Card(
      child: Container(
        width: double.infinity,
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_heaerOrder(), _listDetail(), _total()],
        ),
      ),
    );
  }

  Widget order() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 90, left: 10, right: 10),
        child: Container(
          height: 70,
          width: double.infinity,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.blue,
            onPressed: () {
              accepOrder();
            },
            child: Text(
              'ຮັບສີນຄ້າ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
