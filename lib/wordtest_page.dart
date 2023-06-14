import 'package:flutter/material.dart';
import 'package:wordapp/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WordTestPage(),
    );
  }
}

class WordTestPage extends StatefulWidget {
  @override
  State<WordTestPage> createState() => _WordTestPageState();
}

class _WordTestPageState extends State<WordTestPage> {
  mainPageState main = new mainPageState();

  String currentWord = "";
  TextEditingController answerController = TextEditingController();

  String start() {
    if (main.wordList.isNotEmpty) {
      currentWord = main.wordList[0];
      print('$currentWord 현재');
      print('${main.wordList[0]} 리스트');
    }
    return currentWord;
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    start(),
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
                    String userAnswer = answerController.text.trim();
                    if (userAnswer == currentWord) {
                      main.fishNum += 1;
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
    );
  }
}
