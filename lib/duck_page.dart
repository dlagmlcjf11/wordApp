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
      home: DuckPage(),
    );
  }
}

class DuckPage extends StatelessWidget {
  int _exp = 0;
  int _first_exp = 30;
  int _second_exp = 40;
  int _thrid_exp = 50;
  int _level = 1;
  int _fishNum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Image.asset('assets/duck_first.png'),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Lv.$_level 노래 듣는 오리', style: TextStyle(fontWeight: FontWeight.bold),),
                Text('경험치: $_exp/$_first_exp', style: TextStyle(fontWeight: FontWeight.bold),),
                Text('현재 밥 개수: 0', style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _fishNum -= 1;
                _exp += 10;
                if(_fishNum == 0) {
                  //더이상 먹일 수 없다는 알람
                }
                if(_exp >= _first_exp) {
                  _level +=1;
                  //duck_second_png 호출
                } else if(_exp >= _second_exp) {
                  _level +=1;
                  //duck_thrid.png 호출
                } else if(_exp >= _thrid_exp) {
                  //오리가 더이상 성장 할 수 없다는 알람
                }
              },
              child: Text(
                '밥 주기',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
