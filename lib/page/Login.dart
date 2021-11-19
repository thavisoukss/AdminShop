import 'package:adminshop/model/Login.dart';
import 'dart:io';
import 'package:adminshop/page/ButtomNavigator.dart';
import 'package:adminshop/share/dialog.dart';
import 'package:adminshop/share/saveUser.dart';
import 'package:adminshop/api/api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:adminshop/main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isCheck = true;
  UserLogin _userlogin;
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  var token;

  void showNoti() async {
    var notificationDateTime = DateTime.now().add(Duration(seconds: 10));

    var androidPlatform = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        sound: RawResourceAndroidNotificationSound('sound2'),
        importance: Importance.max,
        priority: Priority.high);

    var IOSPltatform = IOSNotificationDetails(
        sound: 'sound2.mp3',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    var platformChanel =
        NotificationDetails(android: androidPlatform, iOS: IOSPltatform);

    await flutterLocalNotificationsPlugin.schedule(
        0, 'test', 'hello', notificationDateTime, platformChanel);

    print('done send notification sms');
  }

  void aboutNotification() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();

    if (Platform.isAndroid) {
      await firebaseMessaging.configure(onBackgroundMessage: (message) {
        print('hello onLunch');
        showNoti();
      }, onMessage: (message) {
        print('hello onMessage');
        showNoti();
      }, onResume: (message) {
        print('hello OnResume');
        showNoti();
      });
    } else if (Platform.isIOS) {
      await firebaseMessaging.configure(onLaunch: (message) {
        print('hello onLunch');
      }, onMessage: (message) {
        print('hello onMessage');
      }, onResume: (message) {
        print('hello OnResume');
      });
    }
  }

  _shareUser(var name, var user) {
    saveUser(shareName: name, value: user);
  }

  Future _saveShopID(var name, var shopID) async {
    saveShopID(shareName: name, value: shopID);
  }

  _login() async {
    var user = userController.text;
    var password = passwordController.text;
    try {
      _userlogin = await apiCall.login(user, password, token);
      print(_userlogin.status);
      if (_userlogin.status == 'success') {
        _shareUser('username', _userlogin.userInfo.username);
        await _saveShopID('shopID', _userlogin.userInfo.shopid);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ButtomNavigation()));
      } else {
        showErrorMessage(context, 'user or password incorrect');
      }
    } on Exception catch (_) {
      showErrorMessage(context, 'some thing wrong');
    }
  }

  getToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    String getToken = await firebaseMessaging.getToken();
    setState(() {
      token = getToken;
    });
    print("my token is " + token);
  }

  @override
  void initState() {
    // TODO: implement initState
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _space(height: 50),
                _logos(),
                Container(
                  child: Text(""),
                ),
                _space(height: 70),
                _user(),
                _space(height: 20),
                _password(),
                _spaceSmall(),
                _remember(),
                _spaceSmall(),
                _loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logos() {
    return Center(
      child: Container(
          width: 200.0,
          height: 200.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assests/img/logos.jpg'),
              ))),
    );
  }

  Widget _space({double height}) {
    return SizedBox(
      height: height,
    );
  }

  Widget _spaceSmall() {
    return SizedBox(
      height: 5,
    );
  }

  Widget _user() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: userController,
          decoration: InputDecoration(
            labelText: 'ປ້ອນຊື່ຜູ້ໃຊ້',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _password() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: 'ປ້ອນລະຫັດຜ່ານ',
            fillColor: Colors.black,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _remember() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Text('Remember me'),
          Checkbox(
              value: isCheck,
              checkColor: Colors.yellowAccent, // color of tick Mark
              activeColor: Colors.grey,
              onChanged: (bool value) {
                setState(() {
                  isCheck = value;
                });
              }),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colors.blue)),
          color: Colors.blue,
          textColor: Colors.white,
          padding: EdgeInsets.all(8.0),
          onPressed: () {
            _login();
          },
          child: Text(
            "ເຂົ້າສູ່ລະບົບ".toUpperCase(),
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
