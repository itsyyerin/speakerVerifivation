import 'package:flutter/material.dart';
import 'home.dart'; // home.dart 파일 import

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('음성의 감시탑'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.white, // 배경색을 완전한 흰색으로 설정
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 이미지 위젯
              Image.asset('assets/loading.png', height: 400), // 이미지 크기 증가



            ],
          ),
        ),
      ),
    );
  }
}
