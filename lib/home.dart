import 'package:flutter/material.dart';
import 'package:thisone/friendscreen.dart';
//import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

AudioPlayer player = AudioPlayer(); // 오디오 플레이어 객체 만들기

class _HomeState extends State<Home> {
  int _selectedIndex = 0; // 바텀네비게이션 인덱스
  String? _selectedFileName; // 음성파일 업로드

  Future<void> _openFilePicker() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4'],
    );
    if (result != null) {
      setState(() {
        _selectedFileName = result.files.single.name;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('파일이 선택되지 않았습니다.')),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FriendScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("HOME"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            Text("AI가 아직 없어용"),
            ElevatedButton(
              onPressed: () {
                _showdialog(context);
              },
              child: Text('결과보기'),
            ),
            ElevatedButton(
              onPressed: _openFilePicker,
              child: Text('업로드하기'),
            ),
            SizedBox(height: 20),
            _selectedFileName != null
                ? Text(
              '선택된 파일: $_selectedFileName',
              style: TextStyle(fontSize: 16),
            )
                : Container(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervisor_account),
            label: '친구',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

Future<dynamic> _showdialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('이게결과다'),
      content: const Text('이게 결과 내용이다.'),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('되돌아가기'),
        ),
      ],
    ),
  );
}
