import 'neis_client.dart';
import 'models/school_info.dart';
import 'models/meal_info.dart';

class Neis {
  final NeisClient _client;
  SchoolInfo? _school;
  List<MealInfo> _meals = [];

  Neis({required String apiKey}) : _client = NeisClient(apiKey: apiKey);

  Future<void> loadSchoolInfo(String name) async {
    final result = await _client.fetchSchools(schoolName: name);
    if (result.isEmpty) throw Exception('학교를 찾을 수 없습니다.');
    _school = result.first;

    // 오늘 날짜 형식: YYYYMMDD
    final today = DateTime.now();
    final date = '${today.year}${_two(today.month)}${_two(today.day)}';

    _meals = await _client.fetchMeals(
      officeCode: _school!.officeCode,
      schoolCode: _school!.schoolCode,
      date: date,
    );
  }

  // getter: 학교 정보
  String get officeCode => _school?.officeCode ?? '';
  String get schoolCode => _school?.schoolCode ?? '';
  String get schoolName => _school?.schoolName ?? '';
  List<MealInfo> get meals => _meals;

  // 끼니별 getter
  MealInfo? get breakfast => _meals.firstWhere(
    (e) => e.type == '조식',
    orElse: () => MealInfo(date: '', type: '조식', dishes: []),
  );
  MealInfo? get lunch => _meals.firstWhere(
    (e) => e.type == '중식',
    orElse: () => MealInfo(date: '', type: '중식', dishes: []),
  );
  MealInfo? get dinner => _meals.firstWhere(
    (e) => e.type == '석식',
    orElse: () => MealInfo(date: '', type: '석식', dishes: []),
  );

  String _two(int n) => n.toString().padLeft(2, '0');
}
