import 'services/school_service.dart';
import 'models/school_info.dart';

class NeisClient {
  final String apiKey;

  NeisClient({required this.apiKey});

  Future<List<SchoolInfo>> fetchSchools({required String schoolName}) {
    return SchoolService(apiKey).getSchoolInfo(schoolName);
  }

  // 향후 급식, 시간표, 학사일정 등 기능 추가 예정
}
