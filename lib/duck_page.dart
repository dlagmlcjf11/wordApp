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
      home: DuckPage(),
    );
  }
}

class DuckPage extends StatefulWidget {
  @override
  State<DuckPage> createState() => _DuckPageState();
}

class _DuckPageState extends State<DuckPage> {
  mainPageState main = new mainPageState();
  int _exp = 0;
  int _level = 1;
  int _fishNum = 0;
  int _expCount = 0;
  String _duckName = "노래 듣는 ";

  List<int> _expList = [30, 40, 50];
  Image _img = Image.asset('assets/duck_first.png');

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
                  '현재 밥 개수: $_fishNum',
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
                    if (_fishNum > 0 && _exp != 50) {
                      _fishNum -= 1;
                      _exp += 10;
                      if (_fishNum == 0) {
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
                    if (_fishNum > 0 && _exp == _expList[2]) {
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
    );
  }
}
