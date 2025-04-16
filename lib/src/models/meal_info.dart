class MealInfo {
  final String date;
  final String dish;

  MealInfo({required this.date, required this.dish});

  factory MealInfo.fromJson(Map<String, dynamic> json) {
    return MealInfo(
      date: json['MLSV_YMD'],
      dish: json['DDISH_NM'], // HTML <br/>로 구분된 전체 식단 문자열
    );
  }

  List<String> get breakfast => _extract('[조식]');
  List<String> get lunch => _extract('[중식]');
  List<String> get dinner => _extract('[석식]');

  List<String> _extract(String keyword) {
    final lines = dish.split('<br/>');
    final startIndex = lines.indexWhere((line) => line.contains(keyword));

    if (startIndex == -1) return [];

    final extracted = <String>[];

    for (int i = startIndex + 1; i < lines.length; i++) {
      if (lines[i].contains('[중식]') ||
          lines[i].contains('[석식]') ||
          lines[i].contains('[조식]')) {
        break;
      }
      extracted.add(lines[i].trim());
    }

    return extracted;
  }
}
