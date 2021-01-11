import 'package:adminshop/api/api.dart';
import 'package:adminshop/model/OrderBoardcash.dart';
import 'package:adminshop/page/ListOrderAccept.dart';
import 'package:adminshop/share/saveUser.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int _countAccept = 0;
  int _countInvoice = 0;
  int _countDelivery = 0;

  OrderBoardcast _orderAccept = new OrderBoardcast();
  OrderBoardcast _orderInvoice = new OrderBoardcast();
  OrderBoardcast _orderDelivery = new OrderBoardcast();

  Future _getCount() async {
    int shopID;

    await getShopID(shareName: "shopID").then((value) {
      shopID = value;
    });
    _orderAccept = await apiCall.getOrderBoardcastByStatus(shopID, 'ACCEPTED');
    setState(() {
      _countAccept = _orderAccept.data.length;
    });
    _orderAccept = await apiCall.getOrderBoardcastByStatus(shopID, 'INVOICE');
    setState(() {
      _countInvoice = _orderAccept.data.length;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        child: Column(
          children: [
            _accept(),
            SizedBox(
              height: 4,
            ),
            _crateInvoice(),
            SizedBox(
              height: 4,
            ),
            _createDelivery()
          ],
        ),
      ),
    );
  }

  Widget _accept() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListOrderAccept()))
            .whenComplete(() => null);
      },
      child: Container(
        height: 100,
        width: double.infinity,
        child: Card(
          color: Colors.grey[100],
          child: Container(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: Container(
                        height: 82,
                        width: 70,
                        child: Center(
                            child: Text(
                          _countAccept.toString(),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        )),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    child: Text(
                      'ລາຍການຍອມຮັບສົ່ງສິນຄ້າ ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crateInvoice() {
    return Container(
      height: 100,
      width: double.infinity,
      child: Card(
        color: Colors.grey[100],
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Container(
                      height: 82,
                      width: 70,
                      child: Center(
                          child: Text(
                        _countInvoice.toString(),
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      )),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  child: Text(
                    'ລາຍການອອກໃບສະເໜີລາຄາ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createDelivery() {
    return Container(
      height: 100,
      width: double.infinity,
      child: Card(
        color: Colors.grey[100],
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Container(
                      height: 82,
                      width: 70,
                      child: Center(
                          child: Text(
                        _countDelivery.toString(),
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      )),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  child: Text(
                    'ລາຍການສົ່ງເຄື່ອງ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
