import 'package:flutter/material.dart';
import 'package:flutter_neis/flutter_neis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
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

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await neis.loadSchoolInfo('경북소프트웨어마이스터고등학교');
    } catch (e) {
      debugPrint('급식 로드 오류: $e');
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text('${neis.schoolName} 급식 정보')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMealSection('🍞 조식', neis.breakfast),
              _buildMealSection('🍱 중식', neis.lunch),
              _buildMealSection('🍛 석식', neis.dinner),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealSection(String title, MealInfo? meal) {
    if (meal == null || meal.dishes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...meal.dishes.map((dish) => Text(dish)).toList(),
        const SizedBox(height: 16),
      ],
    );
  }
}
