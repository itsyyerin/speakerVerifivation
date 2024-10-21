import 'package:flutter/material.dart';
import 'home.dart'; // Home.dart 화면을 불러오기 위한 import
import 'loading.dart'; // Loading.dart 화면을 불러오기 위한 import

class DifferentImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // 사진을 화면에 크게 표시
          Expanded(
            child: Image.asset(
              'assets/different.png', // 표시할 이미지 경로
              fit: BoxFit.cover, // 이미지를 화면에 꽉 채워서 보여줌
              width: double.infinity, // 화면 너비에 맞추기
            ),
          ),

          // 버튼들이 들어갈 공간
          Padding(
            padding: const EdgeInsets.all(16.0), // 버튼 여백 추가
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // 왼쪽 버튼: Home으로 돌아가기
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Text('Home으로 돌아가기'),
                ),

                // 오른쪽 버튼: Loading 화면으로 이동
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Loading()),
                    );
                  },
                  child: Text('Loading 화면으로 이동'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
