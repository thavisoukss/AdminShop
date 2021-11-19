class UserLogin {
  String status;
  UserInfo userInfo;
  String token;

  UserLogin({this.status, this.userInfo, this.token});

  UserLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class UserInfo {
  String username;
  String usertype;
  int shopid;
  String shopname;

  UserInfo({this.username, this.usertype, this.shopid, this.shopname});

  UserInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    usertype = json['usertype'];
    shopid = json['shopid'];
    shopname = json['shopname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['usertype'] = this.usertype;
    data['shopid'] = this.shopid;
    data['shopname'] = this.shopname;
    return data;
  }
}
