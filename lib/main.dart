import 'package:flutter/material.dart';
import 'package:wordapp/wordplus_page.dart';
import 'package:wordapp/wordtest_page.dart';
import 'package:wordapp/duck_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: mainPage(),
      routes: {
        '/wordplus': (context) => WordPlusPage(),
        '/quiz': (context) => WordTestPage(),
      },
    );
  }
}

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  int _fishNum = 0;
  int _quizNum = 0;
  List<String> _wordList = [];

  @override
  void initState() {
    _wordList.add('word');
    _wordList.add('word');
    _wordList.add('word');
    _wordList.add('word');
    _wordList.add('word');
    _wordList.add('word');
    super.initState();
  }

  void _wordPlusNavigation(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/wordplus');
    setState(() {
      _wordList.add(result as String);
    });
  }
  void _wordTestNavigation(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/quiz');
  }

  _showAlert(context, index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //title: Text('제목'),
            content: Text("'${_wordList[index]}'를 삭제하려면 OK를 누르세요."),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    _wordList.removeAt(index);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text(
            'title',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      _topContent(),
                      _middleContent(),
                      SizedBox(
                        height: 15,
                      ),
                      _bottomContent(),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: WordTestPage(),
            ),
            Container(
              child: DuckPage(),
            ),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.article_outlined),
              text: '단어장',
            ),
            Tab(
              icon: Icon(Icons.quiz),
              text: '단어 테스트',
            ),
            Tab(
              icon: Icon(Icons.favorite),
              text: '오리',
            ),
          ],
        ),
      ),
    );
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
              onPressed: () {
                _wordPlusNavigation(context);
              },
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _middleContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 330,
        child: ListView.builder(
          itemCount: _wordList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 400,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 270,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                _wordList[index],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _showAlert(context, index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _bottomContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Image.asset('assets/fish.png'),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Positioned(
                      child: Text(
                        '$_fishNum개',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: (){
                _wordTestNavigation(context);
              },
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      child: Image.asset('assets/quiz.png'),
                      width: 80,
                      height: 80,
                    ),
                    top: 28,
                    left: 33,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '바로가기',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
