import 'package:flutter/material.dart';
import 'home.dart'; // Home.dart 화면을 불러오기 위한 import

class SameImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            // 이미지를 클릭하면 Home 화면으로 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          child: Image.asset(
            'assets/same.png', // 표시할 이미지 경로
            fit: BoxFit.cover, // 이미지를 화면에 꽉 채워서 보여줌
            width: double.infinity, // 화면 너비에 맞추기
            height: double.infinity, // 화면 높이에 맞추기
          ),
        ),
      ),
    );
  }
}
