import 'package:flutter/material.dart';
import 'dart:async';  // 비동기 처리와 지연 처리에 필요
import 'home.dart';  // home.dart 파일 import
import 'package:thisone/same.dart';  // 동일인 결과 페이지 import
import 'package:thisone/different.dart';  // 비동일인 결과 페이지 import
import 'fastapi.dart';  // 서버와 통신을 위한 fastapi.dart import
import 'dart:io';  // 파일 처리를 위한 dart:io

class Loading extends StatefulWidget {
  final File audioFile1;  // 첫 번째 음성 파일
  final File audioFile2;  // 두 번째 음성 파일

  const Loading({super.key, required this.audioFile1, required this.audioFile2});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _processSpeakerRecognition();  // 화면이 로드되면 바로 실행
  }

  Future<void> _processSpeakerRecognition() async {
    try {
      // 서버로 음성 파일을 보내고 결과를 받음
      final result = await _apiService.compareSpeakers(widget.audioFile1, widget.audioFile2);

      // null 체크 후 결과 접근
      if (result != null && result['result'] != null) {
        final similarity = result['similarity_score'] ?? 0.0;  // 유사도 값이 없으면 0.0
        final comparisonResult = result['result'];

        // 결과에 따라 동일인 또는 비동일인 화면으로 이동
        if (comparisonResult == 'same') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SameImageScreen(similarity: similarity)),  // 동일인 화면으로 이동
          );
        } else if (comparisonResult == 'different') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DifferentImageScreen(similarity: similarity)),  // 비동일인 화면으로 이동
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('결과를 처리하는 중 오류가 발생했습니다.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('서버로부터 올바른 응답을 받지 못했습니다.')),
        );
      }
    } catch (e) {
      // 예외 처리
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('서버와 통신하는 중 문제가 발생했습니다.')),
      );
    }
  }

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
              // 로딩 이미지
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
