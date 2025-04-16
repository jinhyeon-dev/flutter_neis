import 'package:flutter_neis/flutter_neis.dart';

class NeisClient {
  final String apiKey;

  NeisClient({required this.apiKey});

  // 학교 정보
  Future<List<SchoolInfo>> fetchSchools({required String schoolName}) {
    return SchoolService(apiKey).getSchoolInfo(schoolName);
  }

  // 급식 정보
  Future<List<MealInfo>> fetchMeals({
    required String officeCode,
    required String schoolCode,
    required String date,
  }) {
    return MealService(
      apiKey,
    ).getMeals(officeCode: officeCode, schoolCode: schoolCode, date: date);
  }

  Future<List<MealInfo>> fetchMealsBySchoolName({
    required String schoolName,
    required String date,
  }) async {
    final schools = await fetchSchools(schoolName: schoolName);

    if (schools.isEmpty) {
      throw Exception('해당 학교를 찾을 수 없습니다.');
    }

    final school = schools.first;

    return fetchMeals(
      officeCode: school.officeCode,
      schoolCode: school.schoolCode,
      date: date,
    );
  }
}
