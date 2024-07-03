import 'package:flutter/material.dart';
import 'package:thisone/friendscreen.dart';
import 'package:thisone/HeaderFooter.dart';
import 'package:thisone/home.dart';
import 'package:thisone/config/mySqlConnector.dart';
import 'package:thisone/loginPage/loginMainPage.dart';
import 'package:mysql_client/mysql_client.dart';


void main() {
  dbConnector(); // mySQLConnector.dart의 dbConnector 함수 호출
  runApp(const MyApp());    //MyApp() -> const MyApp()으로 변경
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //여기서부터 예린이코드
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Home() //LoginPage()
    );
  }
}