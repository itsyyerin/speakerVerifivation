import 'package:flutter/material.dart';
import 'package:thisone/home.dart';

class DifferentImageScreen extends StatefulWidget {
  final double similarity;  // 유사도 값을 받는 변수 추가

  const DifferentImageScreen({super.key, required this.similarity});  // 유사도 값을 생성자에서 전달받도록 수정

  @override
  _DifferentImageScreenState createState() => _DifferentImageScreenState();
}

class _DifferentImageScreenState extends State<DifferentImageScreen> {

  @override
  void initState() {
    super.initState();
    // 화면이 로드되면 경고창을 띄움
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showWarningDialog();
    });
  }

  // 경고창을 띄우는 함수
  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          title: const Text('[ 주의 ]',
              textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold), // '비동일인'만 빨간색
          ),  // 경고창 제목
          content: const Text('비동일인이 의심됩니다.',
              textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold), // '비동일인'만 빨간색
          ),  // 경고창 내용
          actions: <Widget>[
            TextButton(
              child: const Text('확인',
                style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();  // 경고창 닫기
              },
            ),
          ],
        );
      },
    );
  }

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
            const SizedBox(height: 20),
            // 유사도 점수를 표시하는 부분 추가
            Text(
              '유사도 점수: ${widget.similarity.toStringAsFixed(2)}',  // 유사도 값을 소수점 2자리로 표시
              style: const TextStyle(fontSize: 20),
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
