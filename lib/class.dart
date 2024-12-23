class Weather {
  final String cityName;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}
