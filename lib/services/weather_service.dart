import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = "YOUR_API_KEY"; // 🔑 OpenWeatherMap API key
  static const String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  static Future<Map<String, dynamic>?> fetchWeather(double lat, double lon) async {
    try {
      final url = Uri.parse("$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print("Weather fetch error: $e");
    }
    return null;
  }
}
