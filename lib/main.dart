import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      },
    );
  }
}

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => mainPageState();
}

class mainPageState extends State<mainPage> {
  String? word = "";
  String? mean = "";
  mainPageState({this.word, this.mean});
  int fishNum = 0;
  int quizNum = 0;
  List<String> wordList = [];
  List<String> meanList = [];
  int _exp = 0;
  int _level = 1;
  int _expCount = 0;
  String _duckName = "노래 듣는 ";
  int listIdx = 0;
  bool isMean = false;

  List<int> _expList = [30, 40, 50];
  Image _img = Image.asset('assets/duck_first.png');

  String currentWord = "";
  TextEditingController answerController = TextEditingController();

  void getWord() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('word') == null) {
      word = " ";
    } else {
      word = pref.getString('word');
    }
    if (pref.getString('mean') == null) {
      mean = " ";
    } else {
      mean = pref.getString('mean');
    }
    print(word);
    print(mean);
    wordList.add("$word");
    meanList.add("$mean");
  }

  @override
  void initState() {
    wordList.add('duck');
    meanList.add("오리");
    if (wordList.isNotEmpty) {
      currentWord = wordList[listIdx];
    }
    super.initState();
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  void _wordPlusNavigation(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/wordplus');
    setState(() {
      wordList.add(result as String);
    });
  }

  _showDeleteAlert(context, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("'${wordList[index]}'를 삭제하려면 OK를 누르세요."),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  wordList.removeAt(index);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  _showSucAlert(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: AlertDialog(
            title: Text('퀴즈를 다 풀었습니다! '),
            content: Text('물고기를 얻었어요! 현재 물고기 : $fishNum'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('닫기'),
              ),
            ],
          ),
        );
      },
    );
  }

  _showMean(context, index) {
    return isMean ? meanList[index] : wordList[index];
  }

  _showSucSnack() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('정답이에요!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  _showFailSnack() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('틀렸어요!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: Text(
            'Worduck',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: TextButton(
            onPressed: () {
              setState(() {
                if (isMean == false) {
                  isMean = true;
                } else {
                  isMean = false;
                }
              });
            },
            child: Text(
              "한/영",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  getWord();
                });
              },
              icon: Icon(
                Icons.refresh,
                size: 30,
              ),
            ),
          ],
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
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    '단어 퀴즈',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 350,
                          height: 350,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              currentWord,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: answerController,
                          decoration: InputDecoration(hintText: '단어의 뜻을 입력하세요'),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(
                            () {
                              if (answerController.text.trim() != meanList[listIdx]) {
                                _showFailSnack();
                                answerController.text = "";
                                return;
                              }
                              if (answerController.text.trim() ==
                                      meanList[listIdx] &&
                                  wordList.length - 1 > listIdx) {
                                _showSucSnack();
                                answerController.text = "";
                                listIdx += 1;
                                currentWord = wordList[listIdx];
                              } else if (listIdx == wordList.length - 1) {
                                fishNum += 5;
                                _showSucAlert(context);
                                quizNum += 1;
                                listIdx = 0;
                                currentWord = wordList[listIdx];
                                answerController.text = "";
                              }
                            },
                          );
                        },
                        child: Text(
                          '확인',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    '오리',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 350,
                          height: 350,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: _img,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Lv.$_level $_duckName오리',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '경험치: $_exp/${_expList[_expCount]}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '현재 밥 개수: $fishNum',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(
                            () {
                              if (fishNum > 0 && _exp != 50) {
                                fishNum -= 1;
                                _exp += 10;
                                if (fishNum == 0) {
                                  //더이상 먹일 수 없다는 알람
                                }
                                if (_exp == _expList[0]) {
                                  _level += 1;
                                  _expCount++;
                                  _duckName = "보드 타는 ";
                                  _img = Image.asset('assets/duck_second.png');
                                } else if (_exp == _expList[1]) {
                                  _level += 1;
                                  _expCount++;
                                  _duckName = "서핑 하는 ";
                                  _img = Image.asset('assets/duck_third.png');
                                }
                              }
                              if (fishNum > 0 && _exp == _expList[2]) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('오리가 더 이상 밥을 먹지 않습니다!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          );
                        },
                        child: Text(
                          '밥 주기',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
          itemCount: wordList.length,
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
                                _showMean(context, index),
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
                              _showDeleteAlert(context, index);
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
                        '$fishNum개',
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
              onTap: () {},
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
                        '성공 : $quizNum',
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

class WordPlusPage extends StatefulWidget {
  @override
  State<WordPlusPage> createState() => WordPlusPageState();
}

class WordPlusPageState extends State<WordPlusPage> {
  String word = "";
  String mean = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController wordController = TextEditingController();
  TextEditingController wordMeanController = TextEditingController();

  static void insertWord(String word, String mean) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('word', word);
    pref.setString('mean', mean);
  }

  @override
  void dispose() {
    wordController.dispose();
    wordMeanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          '단어 추가',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: '영단어를 입력하세요',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return '영단어를 입력하세요.';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    this.word = value.toString();
                  });
                },
                controller: wordController,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: '단어의 뜻을 입력하세요',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return '뜻을 입력하세요.';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    this.mean = value.toString();
                  });
                },
                controller: wordMeanController,
                keyboardType: TextInputType.text,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  _formKey.currentState!.save();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('단어 추가 완료! 새로고침을 누르세요.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  print(word);
                  print(mean);
                  insertWord(word, mean);
                }
              },
              child: Text('단어 추가하기'),
            ),
          ],
        ),
      ),
    );
  }
}
