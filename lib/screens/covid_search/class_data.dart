class CovidData {
  final String country;
  final String region;
  final Map<String, Map<String, int>> cases;

  CovidData({
    required this.country,
    required this.region,
    required this.cases,
  });

  factory CovidData.fromJson(Map<String, dynamic> json) {
    Map<String, Map<String, int>> casesMap = {};
    (json['cases'] as Map<String, dynamic>).forEach((key, value) {
      casesMap[key] = Map<String, int>.from(value);
    });

    return CovidData(
      country: json['country'],
      region: json['region'],
      cases: casesMap,
    );
  }
}

