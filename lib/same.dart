import 'package:flutter/material.dart';
import 'package:thisone/home.dart';

class SameImageScreen extends StatelessWidget {
  final double similarity;  // 유사도 값을 받는 변수 추가

  const SameImageScreen({super.key, required this.similarity});  // 유사도 값을 생성자에서 전달받도록 수정

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
                  style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold), // '동일인'만 빨간색
                ),
                Text(
                  '임이 확인되었습니다.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 유사도 점수를 표시하는 부분 추가
            Text(
              '유사도 점수: ${similarity.toStringAsFixed(2)}',  // 유사도 값을 소수점 2자리로 표시
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            // 동일인 이미지
            Image.asset('assets/same.png', height: 230),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Home 버튼
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),  // Home으로 이동
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

              ],
            ),
          ],
        ),
      ),
    );
  }
}
