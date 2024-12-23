import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:percobaan1/class.dart';

class WeatherService {
  final String apiKey = 'a004676df2ecaa302f79f18ba1c29405';

  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return Weather.fromJson(jsonData); // Gunakan fromJson untuk konversi
    } else {
      throw Exception('Gagal memuat data cuaca');
    }
  }
}
