# flutter_neis
![pub version](https://img.shields.io/pub/v/flutter_neis)

**Flutter에서 NEIS 교육정보 개방 포털을 간편하게 사용할 수 있도록 도와주는 패키지입니다.**  
학교 기본 정보, 급식 정보 등을 학교 이름 기반으로 간단하게 조회할 수 있습니다.

---

## 주요 기능

- 학교 정보 조회
- 급식 정보 조회 (조식 / 중식 / 석식)
- 날짜별 급식 자동 캐싱
- `neis.meal.lunch['YYYYMMDD']` 형태의 선언적 API

---

## 지원 메서드 및 구조

### loadSchoolInfo(String schoolName)

학교 이름으로 학교 정보를 불러옵니다.
교육청 코드(ATPT_OFCDC_SC_CODE)와 학교 코드(SD_SCHUL_CODE)를 자동 저장합니다.

```dart
await neis.loadSchoolInfo('학교명');
print(neis.schoolCode);
print(neis.officeCode);
```

### neis.meal.lunch["YYYYMMDD"]

날짜별 급식 정보를 간단하게 불러옵니다.
조식(breakfast), 중식(lunch), 석식(dinner) 모두 지원하며 내부적으로 캐싱됩니다.

```dart
final lunch = await neis.meal.lunch['20250420'];
print(lunch?.dishes.join(", "));
```

---

## 사용 예시 (학교 정보 + 오늘의 급식 출력)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_neis/flutter_neis.dart';
import 'package:intl/intl.dart';

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
  final neis = Neis(apiKey: 'YOUR-API-KEY');
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
    final lunch = await neis.meal.lunch[today];

    setState(() {
      lunchMenu = lunch?.dishes ?? ['중식 정보 없음'];
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(neis.schoolName)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🍱 오늘의 중식',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...lunchMenu.map((dish) => Text(dish)).toList(),
                ],
              ),
            ),
    );
  }
}
```