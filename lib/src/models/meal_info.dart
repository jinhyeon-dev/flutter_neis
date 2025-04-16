class MealInfo {
  final String date;
  final String type; // '조식', '중식', '석식'
  final List<String> dishes;

  MealInfo({required this.date, required this.type, required this.dishes});

  factory MealInfo.fromJson(Map<String, dynamic> json) {
    return MealInfo(
      date: json['MLSV_YMD'],
      type: json['MMEAL_SC_NM'],
      dishes:
          (json['DDISH_NM'] as String)
              .split('<br/>')
              .map((e) => e.trim())
              .toList(),
    );
  }
}
