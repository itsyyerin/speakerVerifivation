import 'package:flutter/material.dart';
import 'package:thisone/home.dart';

class SameImageScreen extends StatelessWidget {
  const SameImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // 배경색을 아주 연한 회색으로 변경
      appBar: AppBar(
        automaticallyImplyLeading: false, // 기본 뒤로가기 버튼을 숨김
        backgroundColor: Colors.green, // 앱바 배경색을 녹색으로 설정
        title: const Text(
          '음성의 감시탑', // 타이틀 변경
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '화자 검증이 완료되었습니다.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '두 화자가 ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '동일인',
                  style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold), // '비동일인'만 빨간색
                ),
                Text(
                  '임이 확인되었습니다.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // 큰 X 아이콘 추가
            Image.asset('assets/same.png', height: 230),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()), // home.dart의 Home 위젯으로 이동
                );
              },
              child:
              Image.asset('assets/goback.png', height: 40),
            ),
          ],
        ),
      ),
    );
  }
}
