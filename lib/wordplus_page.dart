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
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: wordController,
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
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
            child: Text('추가하기'),
          ),
        ],
      ),
    );
  }
}