import 'package:http/http.dart';
import 'dart:convert';

class Weather {
  String _apiKey = "947445ee0a9df1986f81bdba5e936ed2";
  String _baseURL =
      "http://api.openweathermap.org/data/2.5/weather?units=metric&";

  Future fetchCurrentWeatherData(double lat, double long) async {
    try {
      Response resp = await get('${_baseURL}lat=$lat&lon=$long&appid=$_apiKey');

      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      }
    } catch (e) {
      return null;
    }
  }
}
