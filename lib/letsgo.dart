import 'package:flutter/material.dart';
import 'home.dart'; // home.dart 파일 import

class LetsGo extends StatelessWidget {
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
    ),),
      body: Container(
        color: Colors.white, // 배경색을 완전한 흰색으로 설정
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 이미지 위젯
              Image.asset('assets/letsgo.png', height: 300), // 이미지 크기 증가

              const Text(
                '음성의 감시탑',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const Text(
                '화자 인식을 시작하시겠습니까?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // "Start it!" 버튼
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()), // home.dart의 Home 위젯으로 이동
                  );
                },
                child: Text(
                  '    Start it!    ',
                  style: TextStyle(fontSize: 24, color: Colors.white), // 버튼 텍스트 색상 흰색
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // 버튼 배경색 초록색
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // 버튼 패딩 조정
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
