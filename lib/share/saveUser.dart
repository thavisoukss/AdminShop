import 'package:shared_preferences/shared_preferences.dart';

void saveUser({String shareName, String value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(shareName, value);
}

Future<String> getUser({String shareName}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String data = prefs.getString(shareName);
  return data;
}

void saveShopID({String shareName, var value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(shareName, value);
}

void saveUserName({String shareName, var value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(shareName, value);
}

Future<int> getShopID({String shareName}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int data = prefs.getInt(shareName);
  return data;
}

Future<String> getUsername({String shareName}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String data = prefs.getString(shareName);
  return data;
}
