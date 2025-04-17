# flutter_neis

[![pub package](https://img.shields.io/pub/v/flutter_neis.svg)](https://pub.dev/packages/flutter_neis)

Flutter에서 **NEIS 교육정보 개방 포털** API를 간편하게 사용할 수 있도록 도와주는 패키지입니다.  
학교 정보, 급식 정보 등을 **학교 이름 기반으로 선언적**으로 조회할 수 있습니다.

---

## 주요 기능

- 학교 정보 조회
- 급식 정보 조회 (조식 / 중식 / 석식)
- 날짜별 급식 자동 캐싱
- `neis.meal.lunch['YYYYMMDD']` 형태의 선언적 API 제공

---

## 시작하기

### 1. 설치

`pubspec.yaml`에 다음 의존성을 추가하세요:

```yaml
dependencies:
  flutter_neis: ^최신버전
```

### 2. 간단한 사용법

```dart
import 'package:flutter_neis/flutter_neis.dart';

final neis = Neis(apiKey: 'YOUR-API-KEY');

// 학교 정보 불러오기
await neis.loadSchoolInfo('경북소프트웨어마이스터고등학교');

// 오늘의 중식 불러오기
final lunch = await neis.meal.lunch['20250420'];
print(lunch?.dishes.join(", "));
```

### 3. 사용가능한 메서드

#### Future<void> loadSchoolInfo(String schoolName)

학교 이름으로 정보를 조회합니다.
교육청 코드(ATPT_OFCDC_SC_CODE)와 학교 코드(SD_SCHUL_CODE)는 자동 저장됩니다.

```dart
await neis.loadSchoolInfo('학교명');
print(neis.officeCode);  // 예: D10
print(neis.schoolCode);  // 예: 7240450
```

#### Future<Meal?> neis.meal.lunch['YYYYMMDD']

해당 날짜의 중식 정보를 조회합니다.
조식(breakfast), 석식(dinner)도 동일한 방식으로 조회 가능하며, 내부적으로 캐싱됩니다.

```dart
final lunch = await neis.meal.lunch['20250420'];
print(lunch?.dishes ?? ['중식 정보 없음']);
```

## 예제

```dart
import 'package:flutter/material.dart';
import 'package:flutter_neis/flutter_neis.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
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
  List<String> lunchMenu = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
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
                  ...lunchMenu.map((dish) => Text(dish)),
                ])));
  }
}
```

### 참고 사항
주의
본 패키지를 사용하려면 NEIS에서 발급받은 API 키가 필요합니다.
👉 [NEIS 교육정보 개방 포털](https://open.neis.go.kr)에서 키를 발급받으세요.

### 향후 지원 예정
- 학사 일정
- 시간표 정보
- 기타

### 관련 링크
[공식 사이트: NEIS 교육정보 개방 포털](https://open.neis.go.kr)
[flutter_neis pub.dev 페이지](https://pub.dev/packages/flutter_neis)

## 🙌 Contributing

이 패키지는 여러분의 기여를 환영합니다!  
이슈 제보, 기능 개선 제안, PR 모두 자유롭게 남겨주세요.