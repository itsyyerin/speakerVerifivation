import 'package:flutter/material.dart';
import 'home.dart'; // home.dart 파일 import

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 기본 뒤로가기 버튼을 숨김
        backgroundColor: Colors.green,
        title: Row(
          children: const [
            Icon(Icons.mic, color: Colors.white), // 마이크 아이콘 추가
            SizedBox(width: 10),
            Text(
              '음성의 감시탑', // 타이틀 변경
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white, // 배경색을 완전한 흰색으로 설정
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 이미지 위젯
              Image.asset('assets/loading.png', height: 400), // 이미지 크기 약간 감소
              const SizedBox(height: 10), // 텍스트와 이미지 사이 간격을 좁힘
              const Text(
                '음성 분석을 진행중입니다.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10), // 두 번째 텍스트와의 간격을 조금 좁힘
              const Text(
                '잠시만 기다려주세요.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
