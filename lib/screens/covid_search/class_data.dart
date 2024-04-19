class CovidData {
  final String country;
  final int deaths;
  final String month;

  CovidData({required this.country, required this.deaths, required this.month});

  factory CovidData.fromJson(Map<String, dynamic> json) {
    return CovidData(
      country: json['country'],
      deaths: json['deaths'],
      month: json['month'],
    );
  }
}