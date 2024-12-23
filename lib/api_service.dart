import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<List<dynamic>> fetchPhotos() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cacheData = prefs.getString('photos');

      if (cacheData != null) {
        return json.decode(cacheData) as List<dynamic>;
      } else {
        final response = await http
            .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

        if (response.statusCode == 200) {
          prefs.setString('photos', response.body);
          return json.decode(response.body) as List<dynamic>;
        } else {
          throw Exception('Gagal memuat data');
        }
      }
    } catch (e) {
      throw Exception('Kesalahan: $e');
    }
  }
}
