import 'package:flutter/material.dart';
import 'package:thisone/home.dart';

class DifferentImageScreen extends StatelessWidget {
  const DifferentImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 기본 뒤로가기 버튼을 숨김
        backgroundColor: Colors.green, // 상단바 배경색을 녹색으로 변경
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '화자 검증이 완료되었습니다.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // '두 화자가 비동일인임이 확인되었습니다.' 한 줄로 출력
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '두 화자가 ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '비동일인',
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
            Image.asset('assets/different.png', height: 230),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Home 버튼
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // 배경 흰색
                    side: const BorderSide(color: Colors.green), // 테두리 초록색
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 35), // 버튼 크기 조정
                  ),
                  child: const Text(
                    'Home',
                    style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 20), // 버튼 사이 여백
                // Retry 버튼
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // 이전 화면으로 돌아가기
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // 배경 초록색
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 35), // 버튼 크기 조정
                  ),
                  child: const Text(
                    'Retry',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

