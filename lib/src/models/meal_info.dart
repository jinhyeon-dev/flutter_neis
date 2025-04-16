class MealInfo {
  final String date;
  final String dish;

  MealInfo({required this.date, required this.dish});

  factory MealInfo.fromJson(Map<String, dynamic> json) {
    return MealInfo(date: json['MLSV_YMD'], dish: json['DDISH_NM']);
  }
}
