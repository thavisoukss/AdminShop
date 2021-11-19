import 'package:adminshop/model/OrderBoardcash.dart';
import 'package:adminshop/page/CreateDelivery.dart';
import 'package:adminshop/page/CreateInvoice.dart';
import 'package:adminshop/share/saveUser.dart';
import 'package:flutter/material.dart';
import 'package:adminshop/api/api.dart';
import 'package:intl/intl.dart'; //for date format

class ListInvoice extends StatefulWidget {
  @override
  _ListInvoiceState createState() => _ListInvoiceState();
}

class _ListInvoiceState extends State<ListInvoice> {
  OrderBoardcast _orderBoardcast;
   final format_currency = new NumberFormat("#,##0.00", "en_US");

  getOrderBoardCash() async {
    int shopID;
    await getShopID(shareName: "shopID").then((value) {
      shopID = value;
    });
    await apiCall.getOrderBoardcastByStatus(shopID, 'INVOID').then((value) {
      setState(() {
        _orderBoardcast = value;
      });
    });
    print(_orderBoardcast.toJson());
  }

  @override
  void initState() {
    // TODO: implement initState
    getOrderBoardCash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('ລາຍການອອກໃບິນ')),
      ),
      body: _listOrderBoardCash(),
    );
  }

  Widget _listOrderBoardCash() {
    return _orderBoardcast == null
        ? Center(
            child: Text('ບໍ່ມີລາຍການສົ່ງສີນຄ້າ'),
          )
        : Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
                itemCount: _orderBoardcast.data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _imgShop(),
                            flex: 2,
                          ),
                          Expanded(
                            child: _detail(_orderBoardcast.data[index]),
                            flex: 7,
                          )
                        ],
                      ),
                    ),
                  );
                }));
  }

  Widget _imgShop() {
    return Container(
        height: 83,
        child: Text(''),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(50)));
  }

  Widget _detail(Data data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateDelivery(
                        OrderNo: data.oRDERNO,
                        ShopID: data.sHOPID,
                        ShopName: data.sHOPNAME,
                        DistID: data.dISTRIBUTORID,
                        DistName: data.dISTRIBUTORNAME)))
            .whenComplete(getOrderBoardCash);
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: Text('ລະຫັດລາຍການ : ' + data.oRDERNO),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text('ວັນທີສັ່ງ :' + data.oRDERDATE),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text('ຮ້ານ : ' + data.sHOPNAME),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
