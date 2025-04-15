// example/main.dart
import 'package:flutter_neis/flutter_neis.dart';

void main() async {
  final neis = NeisClient(apiKey: 'YOUR_API_KEY');

  final schools = await neis.fetchSchools(schoolName: '서울고등학교');

  for (var school in schools) {
    print('${school.schoolName} (${school.officeCode}, ${school.schoolCode})');
  }
}
