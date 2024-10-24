
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:thisone/loading.dart';  // Loading 화면 import
import 'dart:io';
import 'fastapi.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

AudioPlayer player = AudioPlayer();

class _HomeState extends State<Home> {
  String? _selectedFileName1;
  String? _selectedFileName2;
  File? _audioFile1;
  File? _audioFile2;

  final ApiService _apiService = ApiService();

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

  // 화자 인식 시작 버튼을 눌렀을 때 실행
  Future<void> _startSpeakerRecognition() async {
    if (_audioFile1 == null || _audioFile2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('두 개의 음성 파일을 모두 선택해주세요.')),
      );
      return;
    }

    // 로딩 화면으로 넘어가면서 파일 전달
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Loading(audioFile1: _audioFile1!, audioFile2: _audioFile2!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        color: Colors.grey[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '화자 목소리 업로드',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0, right: 0.0),
                      child: Image.asset('assets/microphone.png', height: 30),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _openFilePicker1,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              elevation: 0,
                            ),
                            child: const Text(
                              ' 인식이 필요한 음성파일 ',
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          const Text(
                            '의심되는 화자의 목소리가 들어간 \n음성 파일을 업로드해주세요.',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          if (_selectedFileName1 != null)
                            Text('선택된 파일: $_selectedFileName1', style: const TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/microphone.png', height: 30),
                          const SizedBox(height: 8),
                          Image.asset('assets/video.png', height: 30),
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
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              elevation: 0,
                            ),
                            child: const Text(
                              '  화자의 목소리가 들어간 파일  ',
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          const Text(
                            '알고 싶은 화자의 목소리가 들어간 \n음성 파일 또는 영상 파일을 업로드해주세요.',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          if (_selectedFileName2 != null)
                            Text('선택된 파일: $_selectedFileName2', style: const TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startSpeakerRecognition,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                ),
                child: const Text(
                  '           화자인식 시작          ',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
