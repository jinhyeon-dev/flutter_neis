import 'package:flutter_neis/flutter_neis.dart';

class Neis {
  final NeisClient _client;
  late SchoolInfo _school;

  bool _isLoaded = false;

  Neis({required String apiKey}) : _client = NeisClient(apiKey: apiKey);

  String get schoolName => _isLoaded ? _school.schoolName : '정보 없음';
  String get schoolCode => _school.schoolCode;
  String get officeCode => _school.officeCode;

  Future<void> loadSchoolInfo(String name) async {
    final result = await _client.fetchSchools(schoolName: name);
    if (result.isEmpty) throw Exception('학교를 찾을 수 없습니다.');
    _school = result.first;
    _isLoaded = true;
  }

  Future<List<MealInfo>> meal({required String date}) async {
    if (!_isLoaded) throw Exception('학교 정보를 먼저 불러와야 합니다.');
    return _client.fetchMeals(
      officeCode: _school.officeCode,
      schoolCode: _school.schoolCode,
      date: date,
    );
  }
}
