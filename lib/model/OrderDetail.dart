class OrderDetail {
  String status;
  String message;
  List<Data> data;

  OrderDetail({this.status, this.message, this.data});

  OrderDetail.fromJson(Map<String, dynamic> json) {
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
  int iTEMID;
  String iTEMCODE;
  String iTEMNAME;
  int sUMAMOUNT;
  int pRICE;
  String cCY;
  int sUMSUBTOTAL;
  String dESCRITION;
  String oRDERNO;
  String iNVOIDNO;

  Data(
      {this.iTEMID,
      this.iTEMCODE,
      this.iTEMNAME,
      this.sUMAMOUNT,
      this.pRICE,
      this.cCY,
      this.sUMSUBTOTAL,
      this.dESCRITION,
      this.oRDERNO,
      this.iNVOIDNO});

  Data.fromJson(Map<String, dynamic> json) {
    iTEMID = json['ITEM_ID'];
    iTEMCODE = json['ITEM_CODE'];
    iTEMNAME = json['ITEM_NAME'];
    sUMAMOUNT = json['SUM(AMOUNT)'];
    pRICE = json['PRICE'];
    cCY = json['CCY'];
    sUMSUBTOTAL = json['SUM(SUB_TOTAL)'];
    dESCRITION = json['DESCRITION'];
    oRDERNO = json['ORDER_NO'];
    iNVOIDNO = json['INVOID_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITEM_ID'] = this.iTEMID;
    data['ITEM_CODE'] = this.iTEMCODE;
    data['ITEM_NAME'] = this.iTEMNAME;
    data['SUM(AMOUNT)'] = this.sUMAMOUNT;
    data['PRICE'] = this.pRICE;
    data['CCY'] = this.cCY;
    data['SUM(SUB_TOTAL)'] = this.sUMSUBTOTAL;
    data['DESCRITION'] = this.dESCRITION;
    data['ORDER_NO'] = this.oRDERNO;
    data['INVOID_NO'] = this.iNVOIDNO;
    return data;
  }
}
