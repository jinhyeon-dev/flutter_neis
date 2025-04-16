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
    final meals = neis.meal;

    if (meals.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final todayMeal = meals.first;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (todayMeal.breakfast.isNotEmpty) ...[
              const Text(
                '🍞 조식',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              ...todayMeal.breakfast.map((e) => Text(e)).toList(),
              const SizedBox(height: 12),
            ],
            if (todayMeal.lunch.isNotEmpty) ...[
              const Text(
                '🍱 중식',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...todayMeal.lunch.map((e) => Text(e)).toList(),
              const SizedBox(height: 12),
            ],
            if (todayMeal.dinner.isNotEmpty) ...[
              const Text(
                '🍛 석식',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...todayMeal.dinner.map((e) => Text(e)).toList(),
            ],
          ],
        ),
      ),
    );
  }
}
