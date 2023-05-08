import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wether_app/constant.dart';

class ApiService {
  String apiUrl = "";

  Future<dynamic> fetchNewsData(lat, lon) async {
    apiUrl =
        'https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&appid=${apiKey}';
    final response = await http.get(Uri.parse(apiUrl));
    print("response.body------${response.body}");
    return jsonDecode(response.body);
  }
}
