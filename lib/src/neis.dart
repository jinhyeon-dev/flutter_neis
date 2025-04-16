import 'package:flutter_neis/flutter_neis.dart';
import 'package:flutter_neis/src/services/meal/meal_manager.dart';

class Neis {
  final NeisClient _client;
  SchoolInfo? _school;
  MealManager? _meal;

  Neis({required String apiKey}) : _client = NeisClient(apiKey: apiKey);

  Future<void> loadSchoolInfo(String name) async {
    final schools = await _client.fetchSchools(schoolName: name);
    if (schools.isEmpty) throw Exception('학교를 찾을 수 없습니다.');
    _school = schools.first;
    _meal = MealManager(client: _client, school: _school!);
  }

  // Getter로 쉽게 접근
  String get schoolName => _school?.schoolName ?? '';
  MealManager get meal {
    if (_meal == null) {
      throw Exception('먼저 loadSchoolInfo()를 호출하세요.');
    }
    return _meal!;
  }
}
