import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
      ),
      home: mainPage(),
    );
  }
}

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          'title',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _topContent(),
          _middleContent(),
          _bottomContent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: '단어장',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: '단어 테스트',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: '오리',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget _topContent() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Container(
          width: 400,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              width: 1,
            ),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.18),
                blurRadius: 5.0,
                spreadRadius: 0.0,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '단어 추가하기',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
        ),
      ],
    ),
  );
}

Widget _middleContent() {
  return Text('middle');
}

Widget _bottomContent() {
  return Text('bottom');
}
