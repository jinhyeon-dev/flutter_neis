import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/meal_info.dart';

class MealService {
  final String apiKey;
  final String baseUrl = 'https://open.neis.go.kr/hub/mealServiceDietInfo';

  MealService(this.apiKey);

  Future<List<MealInfo>> getMeals({
    required String officeCode,
    required String schoolCode,
    required String date,
  }) async {
    final uri = Uri.parse(
      '$baseUrl?KEY=$apiKey&Type=json&ATPT_OFCDC_SC_CODE=$officeCode'
      '&SD_SCHUL_CODE=$schoolCode&MLSV_YMD=$date',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rows = data['mealServiceDietInfo']?[1]?['row'] ?? [];

      return rows.map<MealInfo>((e) => MealInfo.fromJson(e)).toList();
    } else {
      throw Exception('급식 정보를 불러올 수 없습니다.');
    }
  }
}
