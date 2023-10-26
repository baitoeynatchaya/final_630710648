import 'package:final_630710648/models/condition.dart';

class Weather {
  final String city;
  final String country;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final double feelsLikeC;
  final double feelsLikeF;
  final double windKph;
  final double windMph;
  final double humidity;
  final int uv;
  final Condition condition;

  Weather({
    required this.city,
    required this.country,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.windKph,
    required this.windMph,
    required this.humidity,
    required this.uv,
    required this.condition
  });
  factory Weather.fromJson(Map<String,dynamic>json){
    Condition condition = Condition.fromJson(json['condition']);
    return Weather(
        city: json['city'],
        country: json ['country'],
        lastUpdated:  json['lastUpdated'],
        tempC: json['tempC'].toDouble(),
        tempF: json['tempF'].toDouble(),
        feelsLikeC: json['feelsLikeC'].toDouble(),
        feelsLikeF: json['feelsLikeF'].toDouble(),
        windKph: json['windKph'].toDouble(),
        windMph: json['windMph'].toDouble(),
        humidity: json['humidity'].toDouble(),
        uv: json['uv'],
        condition: condition
    );
  }
}