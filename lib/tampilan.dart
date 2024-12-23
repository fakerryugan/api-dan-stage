import 'package:flutter/material.dart';
import 'package:percobaan1/class.dart';
import 'api_service.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService weatherService = WeatherService();
  String selectedCity = 'Jakarta'; // Default city
  late Future<Weather> weatherData;

  @override
  void initState() {
    super.initState();
    weatherData = weatherService.fetchWeather(selectedCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuaca Terkini'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dropdown Button with padding and styling
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DropdownButton<String>(
                value: selectedCity,
                onChanged: (String? newCity) {
                  setState(() {
                    selectedCity = newCity!;
                    weatherData = weatherService.fetchWeather(selectedCity);
                  });
                },
                items: <String>[
                  'Jakarta',
                  'Bandung',
                  'Surabaya',
                  'Yogyakarta',
                  'Semarang'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: 16)),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: FutureBuilder<Weather>(
                future: weatherData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child:
                            Text('Gagal memuat data cuaca: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('Tidak ada data cuaca.'));
                  }

                  Weather weather = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cuaca di ${weather.cityName}',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.thermostat_outlined, size: 20),
                            SizedBox(width: 8),
                            Text('Suhu: ${weather.temperature}°C'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.water_drop, size: 20),
                            SizedBox(width: 8),
                            Text('Kelembaban: ${weather.humidity}%'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.air, size: 20),
                            SizedBox(width: 8),
                            Text('Kecepatan Angin: ${weather.windSpeed} m/s'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.description, size: 20),
                            SizedBox(width: 8),
                            Text('Keterangan: ${weather.description}'),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
