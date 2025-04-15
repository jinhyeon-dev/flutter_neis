import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/school_info.dart';

class SchoolService {
  final String apiKey;
  final String baseUrl = 'https://open.neis.go.kr/hub/schoolInfo';

  SchoolService(this.apiKey);

  Future<List<SchoolInfo>> getSchoolInfo(String schoolName) async {
    final uri = Uri.parse(
      '$baseUrl?KEY=$apiKey&Type=json&SCHUL_NM=$schoolName',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rows = data['schoolInfo']?[1]?['row'] ?? [];

      return rows.map<SchoolInfo>((e) => SchoolInfo.fromJson(e)).toList();
    } else {
      throw Exception('학교 정보를 불러올 수 없습니다.');
    }
  }
}
