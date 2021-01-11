class OrderBoardcast {
  String status;
  String message;
  List<Data> data;

  OrderBoardcast({this.status, this.message, this.data});

  OrderBoardcast.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int iD;
  String oRDERNO;
  int sHOPID;
  String sHOPNAME;
  int dISTRIBUTORID;
  String dISTRIBUTORNAME;
  String sTATUS;
  String oRDERDATE;

  Data(
      {this.iD,
      this.oRDERNO,
      this.sHOPID,
      this.sHOPNAME,
      this.dISTRIBUTORID,
      this.dISTRIBUTORNAME,
      this.sTATUS,
      this.oRDERDATE});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    oRDERNO = json['ORDER_NO'];
    sHOPID = json['SHOP_ID'];
    sHOPNAME = json['SHOP_NAME'];
    dISTRIBUTORID = json['DISTRIBUTOR_ID'];
    dISTRIBUTORNAME = json['DISTRIBUTOR_NAME'];
    sTATUS = json['STATUS'];
    oRDERDATE = json['ORDER_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ORDER_NO'] = this.oRDERNO;
    data['SHOP_ID'] = this.sHOPID;
    data['SHOP_NAME'] = this.sHOPNAME;
    data['DISTRIBUTOR_ID'] = this.dISTRIBUTORID;
    data['DISTRIBUTOR_NAME'] = this.dISTRIBUTORNAME;
    data['STATUS'] = this.sTATUS;
    data['ORDER_DATE'] = this.oRDERDATE;
    return data;
  }
}
