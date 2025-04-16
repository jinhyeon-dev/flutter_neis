// lib/src/neis.dart

import 'neis_client.dart';
import 'models/school_info.dart';
import 'models/meal_info.dart';

class Neis {
  final NeisClient _client;
  SchoolInfo? _school;

  Neis({required String apiKey}) : _client = NeisClient(apiKey: apiKey);

  Future<void> loadSchoolInfo(String name) async {
    final result = await _client.fetchSchools(schoolName: name);
    if (result.isEmpty) throw Exception('학교를 찾을 수 없습니다.');
    _school = result.first;
  }

  String get officeCode => _school?.officeCode ?? '';
  String get schoolCode => _school?.schoolCode ?? '';
  String get schoolName => _school?.schoolName ?? '';

  Future<List<MealInfo>> meal({required String date}) async {
    if (_school == null) {
      throw Exception('학교 정보를 먼저 불러와야 합니다.');
    }
    return _client.fetchMeals(
      officeCode: _school!.officeCode,
      schoolCode: _school!.schoolCode,
      date: date,
    );
  }
}
