class SchoolInfo {
  final String officeCode;
  final String schoolCode;
  final String schoolName;

  SchoolInfo({
    required this.officeCode,
    required this.schoolCode,
    required this.schoolName,
  });

  factory SchoolInfo.fromJson(Map<String, dynamic> json) {
    return SchoolInfo(
      officeCode: json['ATPT_OFCDC_SC_CODE'],
      schoolCode: json['SD_SCHUL_CODE'],
      schoolName: json['SCHUL_NM'],
    );
  }
}
