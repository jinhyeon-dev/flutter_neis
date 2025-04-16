import 'package:flutter/material.dart';
import 'package:flutter_neis/flutter_neis.dart';
import 'package:intl/intl.dart'; // 날짜 포맷을 위해 사용

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final neis = Neis(apiKey: '4cb39a23104d459ebe0d394f9900cf5c');
  bool _loading = true;
  List<String> lunchMenu = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await neis.loadSchoolInfo('경북소프트웨어마이스터고등학교');

    final today = DateFormat('yyyyMMdd').format(DateTime.now());
    final lunch = await neis.meal.dinner[today];

    setState(() {
      lunchMenu = lunch?.dishes ?? ['중식 정보 없음'];
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(neis.schoolName)),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🍱 오늘의 중식',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...lunchMenu.map((dish) => Text(dish)).toList(),
                  ],
                ),
              ),
    );
  }
}
