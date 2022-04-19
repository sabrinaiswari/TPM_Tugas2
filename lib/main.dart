import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tugas2/login_page.dart';
import 'package:tugas2/model/akun_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas2/home_page.dart';

Future<void> main() async {
  initiateLocalDB();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool status =  pref.getBool("LoginStatus") ?? false;
  String username = pref.getString("Username") ?? "";
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: status == true ? HomePage(username: username, isLogin: status) : LoginPage(status: false)));
}

void initiateLocalDB() async {
  //await Hive.init();
  Hive.registerAdapter(UserAccountModelAdapter());
  await Hive.openBox<UserAccountModel>("user");
}