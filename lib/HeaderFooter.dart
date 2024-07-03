import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thisone/friendscreen.dart';
import 'package:thisone/home.dart';
import 'package:thisone/loginPage/loginMainPage.dart';

class MyAppPage extends StatefulWidget {
  const MyAppPage({super.key});

  @override
  State<MyAppPage> createState() => MyAppState();
}

class MyAppState extends State<MyAppPage> {
  // 바텀 네비게이션 바 인덱스
  int _selectedIndex = 0;

  final List<Widget> _navIndex = [
    Home(),
    FriendScreen(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(/*
      appBar: CupertinoNavigationBar(
        middle: const Text('Title'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.arrowshape_turn_up_left,
                size: 30,
              ),
              onPressed: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text('알림'),
                    content: const Text('로그아웃하시겠습니까?'),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.pop(context),
                        child: const Text('아니오'),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => LoginMainPage(),
                            ),
                          );
                        },
                        child: Text('예'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),*/
      body: _navIndex.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home_filled),
          //   label: '홈',
          //   backgroundColor: Colors.white,
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.zoom_in),
            label: '홈화면',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervisor_account),
            label: '친구',
          ),

        ],
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      ),

    );
  }
}