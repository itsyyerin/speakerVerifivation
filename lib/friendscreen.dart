import 'package:flutter/material.dart';
import 'package:thisone/friendlist.dart';
import 'package:thisone/home.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  int _selectedIndex = 1; // 바텀네비게이션 인덱스

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
        title: const Text("친구목록"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text("+ 친구 추가"),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              itemCount: FriendList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 100,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${FriendList[index]['name']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                          Text(
                            '${FriendList[index]['relation']}',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
