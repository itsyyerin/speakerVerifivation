import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:thisone/loading.dart';
import 'dart:io';
import 'fastapi.dart'; // ApiService 클래스 import

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

AudioPlayer player = AudioPlayer(); // 오디오 플레이어 객체 만들기

class _HomeState extends State<Home> {
  String? _selectedFileName1; // 첫 번째 음성파일 이름
  String? _selectedFileName2; // 두 번째 음성파일 이름
  List<dynamic>? _mfcc1; // 첫 번째 파일의 MFCC 결과
  List<dynamic>? _mfcc2; // 두 번째 파일의 MFCC 결과
  File? _audioFile1; // 첫 번째 음성파일
  File? _audioFile2; // 두 번째 음성파일

  final ApiService _apiService = ApiService(); // ApiService 인스턴스 생성

  /*확장자검사 및 파일업로드 구역*/
  Future<void> _openFilePicker1() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'm4a', 'mp4'],
    );
    if (result != null) {
      final extension = result.files.single.extension;
      if (extension == 'mp3' || extension == 'm4a' || extension == 'mp4') {
        setState(() {
          _selectedFileName1 = result.files.single.name;
          _audioFile1 = File(result.files.single.path!);
        });
        await _extractMFCC1(); // FastAPI 통신
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('첫 번째 파일의 확장자 에러')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('첫 번째 파일이 선택되지 않았습니다.')),
      );
    }
  }

  Future<void> _openFilePicker2() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'm4a', 'mp4'],
    );
    if (result != null) {
      final extension = result.files.single.extension;
      if (extension == 'mp3' || extension == 'm4a' || extension == 'mp4') {
        setState(() {
          _selectedFileName2 = result.files.single.name;
          _audioFile2 = File(result.files.single.path!);
        });
        await _extractMFCC2(); // FastAPI 통신
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('두 번째 파일의 확장자 에러')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('두 번째 파일이 선택되지 않았습니다.')),
      );
    }
  }

  /*fastapi로 보내서 mfcc추출하는 구역*/
  Future<void> _extractMFCC1() async {
    if (_audioFile1 == null) return;
    print("적합한 화자 업로드 요청을 보냅니다: ${_audioFile1!.path}");
    final mfcc = await _apiService.uploadProperSpeaker(_audioFile1!);
    print("서버로부터 받은 MFCC 데이터: $mfcc");
    if (mfcc != null) {
      setState(() {
        _mfcc1 = mfcc; // MFCC 결과 저장
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('첫 번째 파일의 MFCC 추출에 실패했습니다.')),
      );
    }
  }

  Future<void> _extractMFCC2() async {
    if (_audioFile2 == null) return;
    print("적합한 화자 업로드 요청을 보냅니다: ${_audioFile2!.path}");
    final mfcc = await _apiService.uploadCompareSpeaker(_audioFile2!);
    print("서버로부터 받은 MFCC 데이터: $mfcc");
    if (mfcc != null) {
      setState(() {
        _mfcc2 = mfcc; // MFCC 결과 저장
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('두 번째 파일의 MFCC 추출에 실패했습니다.')),
      );
    }
  }

  /*앱 화면 구성하는 구역*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green, // 앱바 배경색을 녹색으로 변경
        title: const Text(
          "화자검증 어플리케이션 데모버전",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Container(
        color: Colors.grey[200], // 배경색을 아주아주 연한 회색으로 설정
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '화자 목소리 업로드',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // 첫 번째 네모칸
              Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white, // 박스 배경색 흰색
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // 그림자 색상
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: const Offset(2, 2), // 그림자 위치
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0, right: 0.0), // 이미지 위치를 더 오른쪽으로 조정
                      child: Image.asset('assets/microphone.png', height: 30), // 업로드 아이콘 크기 조정
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _openFilePicker1,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // 버튼 배경색 흰색
                              padding: const EdgeInsets.symmetric(vertical: 20), // 버튼 크기 조정
                              elevation: 0, // 그림자 제거
                            ),
                            child: const Text(
                              ' 검증이 필요한 음성파일 ',
                              style: TextStyle(fontSize: 20, color: Colors.black), // 글자 색상 검은색
                            ),
                          ),
                          const Text(
                            '의심되는 화자의 목소리가 들어간 \n음성 파일을 업로드해주세요.',
                            style: TextStyle(fontSize: 12, color: Colors.black), // 작은 글씨
                          ),
                          if (_selectedFileName1 != null)
                            Text('선택된 파일: $_selectedFileName1', style: const TextStyle(fontSize: 10)),
                          if (_mfcc1 != null)
                            const Text('특징 추출이 완료되었습니다.', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 두 번째 네모칸
              Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white, // 박스 배경색 흰색
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // 그림자 색상
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: const Offset(2, 2), // 그림자 위치
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 8.0), // 왼쪽 여백 추가
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/microphone.png', height: 30), // 첫 번째 아이콘
                          const SizedBox(height: 8), // 아이콘 간격
                          Image.asset('assets/video.png', height: 30), // 두 번째 아이콘
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _openFilePicker2,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // 버튼 배경색 흰색
                              padding: const EdgeInsets.symmetric(vertical: 20), // 버튼 크기 조정
                              elevation: 0, // 그림자 제거
                            ),
                            child: const Text(
                              '  화자의 목소리가 들어간 파일  ',
                              style: TextStyle(fontSize: 20, color: Colors.black), // 글자 색상 검은색
                            ),
                          ),
                          const Text(
                            '알고 싶은 화자의 목소리가 들어간 \n음성 파일 또는 영상 파일을 업로드해주세요.',
                            style: TextStyle(fontSize: 12, color: Colors.black), // 작은 글씨
                          ),
                          if (_selectedFileName2 != null)
                            Text('선택된 파일: $_selectedFileName2', style: const TextStyle(fontSize: 10)),
                          if (_mfcc2 != null)
                            const Text('특징 추출이 완료되었습니다', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // "비교하기" 버튼
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Loading()), // home.dart의 Home 위젯으로 이동
                  );
                }, // 아직 기능 없음
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // 버튼 배경색 흰색
                  padding: const EdgeInsets.symmetric(vertical: 15), // 버튼 크기 조정
                  elevation: 0, // 그림자 제거
                ),
                child: const Text(
                  '           비교하기           ',
                  style:
                      TextStyle(fontSize: 20, color: Colors.black), // 글자 색상 검은색
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
