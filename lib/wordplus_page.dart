import 'package:flutter/material.dart';

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
      home: WordPlusPage(),
    );
  }
}

class WordPlusPage extends StatelessWidget {
  TextEditingController wordController = new TextEditingController();
  TextEditingController wordMeanController = new TextEditingController();

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: '영단어를 입력하세요',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
              ),
              controller: wordController,
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: '단어의 뜻을 입력하세요',
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  ),
              ),
              controller: wordMeanController,
              keyboardType: TextInputType.text,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                wordController.value.text,
              );
            },
            child: Text('단어 추가하기'),
          ),
        ],
      ),
    );
  }
}