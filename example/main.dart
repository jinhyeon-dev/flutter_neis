import 'package:flutter/material.dart';
import 'package:flutter_neis/flutter_neis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final neis = Neis(apiKey: '4cb39a23104d459ebe0d394f9900cf5c');

  @override
  void initState() {
    super.initState();
    neis.loadSchoolInfo('경북소프트웨어마이스터고등학교').then((_) {
      setState(() {}); // school 값 갱신 시 화면 재빌드
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: Text(neis.schoolCode))),
    );
  }
}
