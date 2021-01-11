import 'package:adminshop/share/dialog.dart';
import 'package:adminshop/share/saveUser.dart';
import 'package:flutter/material.dart';
import 'package:adminshop/model/OrderDetail.dart' as detail;
import 'package:adminshop/api/api.dart';
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

  double total;
  String userName;

  List<detail.Data> _listOrder = new List<detail.Data>();
  detail.Data res = new detail.Data();

  Future _orderDetail() async {
    apiCall.getOrderDetail(_orderNo).then((value) {
      setState(() {
        orderDetail = value;
        total = orderDetail.data
            .map<double>((m) => double.parse(m.sUMSUBTOTAL.toString()))
            .reduce((a, b) => a + b);
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
      body: orderDetail == null
          ? Container(
              child: Text(''),
            )
          : Column(
              children: [
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Text(
                                'ລຳດັບ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Center(
                              child: Container(
                                child: Text(
                                  'ລາຍການສິນຄ້າ ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                child: Text(
                                  'ຈຳນວນ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Container(
                                child: Text(
                                  'ລາຄາ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Detail(),
                  flex: 7,
                ),
                Expanded(
                  child: Total(),
                  flex: 2,
                ),
              ],
            ),
    );
  }

  Widget Detail() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: ListView.builder(
            itemCount: orderDetail.data.length,
            itemBuilder: (context, index) {
              return Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Text(index.toString()),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Container(
                          child: Text(orderDetail.data[index].iTEMNAME),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Container(
                          child: Text(
                              orderDetail.data[index].sUMAMOUNT.toString()),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Container(
                          child: Text(NumberFormat()
                              .format(orderDetail.data[index].pRICE)),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget Total() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: 70,
          width: double.infinity,
          child: RaisedButton(
            color: Colors.blue,
            onPressed: () {
              accepOrder();
            },
            child: Text(
              'ລວມທັງໝົດ :' + NumberFormat().format(total),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
