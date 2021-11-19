class GetOrderAccept {
  String status;
  String message;
  List<Data> data;

  GetOrderAccept({this.status, this.message, this.data});

  GetOrderAccept.fromJson(Map<String, dynamic> json) {
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
  String oRDERACCEPTNO;
  String aCCEPTDATE;
  String aCCEPTUSER;
  String oRDERNO;
  int sHOPID;
  String sHOPNAME;
  int dISTRIBUTORID;
  String dISTRIBUTORNAME;
  String dELIVERLYDATETIME;
  int tOTALAMOUNT;
  String cCY;
  String sTATUS;

  Data(
      {this.iD,
      this.oRDERACCEPTNO,
      this.aCCEPTDATE,
      this.aCCEPTUSER,
      this.oRDERNO,
      this.sHOPID,
      this.sHOPNAME,
      this.dISTRIBUTORID,
      this.dISTRIBUTORNAME,
      this.dELIVERLYDATETIME,
      this.tOTALAMOUNT,
      this.cCY,
      this.sTATUS});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    oRDERACCEPTNO = json['ORDER_ACCEPT_NO'];
    aCCEPTDATE = json['ACCEPT_DATE'];
    aCCEPTUSER = json['ACCEPT_USER'];
    oRDERNO = json['ORDER_NO'];
    sHOPID = json['SHOP_ID'];
    sHOPNAME = json['SHOP_NAME'];
    dISTRIBUTORID = json['DISTRIBUTOR_ID'];
    dISTRIBUTORNAME = json['DISTRIBUTOR_NAME'];
    dELIVERLYDATETIME = json['DELIVERLY_DATE_TIME'];
    tOTALAMOUNT = json['TOTAL_AMOUNT'];
    cCY = json['CCY'];
    sTATUS = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ORDER_ACCEPT_NO'] = this.oRDERACCEPTNO;
    data['ACCEPT_DATE'] = this.aCCEPTDATE;
    data['ACCEPT_USER'] = this.aCCEPTUSER;
    data['ORDER_NO'] = this.oRDERNO;
    data['SHOP_ID'] = this.sHOPID;
    data['SHOP_NAME'] = this.sHOPNAME;
    data['DISTRIBUTOR_ID'] = this.dISTRIBUTORID;
    data['DISTRIBUTOR_NAME'] = this.dISTRIBUTORNAME;
    data['DELIVERLY_DATE_TIME'] = this.dELIVERLYDATETIME;
    data['TOTAL_AMOUNT'] = this.tOTALAMOUNT;
    data['CCY'] = this.cCY;
    data['STATUS'] = this.sTATUS;
    return data;
  }
}
