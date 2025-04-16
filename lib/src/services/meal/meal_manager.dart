import 'package:flutter_neis/flutter_neis.dart';

class MealManager {
  final NeisClient client;
  final SchoolInfo school;
  final Map<String, List<MealInfo>> _cache = {};

  MealManager({required this.client, required this.school});

  Future<List<MealInfo>> _getMeals(String date) async {
    if (!_cache.containsKey(date)) {
      final meals = await client.fetchMeals(
        officeCode: school.officeCode,
        schoolCode: school.schoolCode,
        date: date,
      );
      _cache[date] = meals;
    }
    return _cache[date]!;
  }

  MealTypeGetter get breakfast => MealTypeGetter(this, '조식');
  MealTypeGetter get lunch => MealTypeGetter(this, '중식');
  MealTypeGetter get dinner => MealTypeGetter(this, '석식');
}

class MealTypeGetter {
  final MealManager manager;
  final String type;

  MealTypeGetter(this.manager, this.type);

  Future<MealInfo?> operator [](String date) async {
    final list = await manager._getMeals(date);
    return list.firstWhere(
      (m) => m.type == type,
      orElse: () => MealInfo(date: date, type: type, dishes: []),
    );
  }
}
