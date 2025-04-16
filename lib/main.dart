import 'package:flutter/material.dart';
import 'package:flutter_neis/flutter_neis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final neis = Neis(apiKey: '4cb39a23104d459ebe0d394f9900cf5c');

  @override
  void initState() {
    super.initState();
    neis.loadSchoolInfo('경북소프트웨어마이스터고등학교').then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(neis.officeCode)));
  }
}
