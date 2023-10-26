import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_630710648/models/weather.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _dio = Dio(BaseOptions(responseType: ResponseType.plain));
  String? _error;
  Weather? _weather;
  void getWeathers() async{
    try {
      setState(() {
        _error = null;
      });
      final response = await _dio.get('https://cpsu-test-api.herokuapp.com/api/1_2566/weather/current?city=bangkok');
      debugPrint(response.data.toString());

      Map<String, dynamic> data = jsonDecode(response.data.toString());
      Weather weather = Weather.fromJson(data);

      setState(() {
        _weather = weather;
    });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getWeathers();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_error != null) {
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                getWeathers();
              },
              child: const Text('RETRY'),
            )
          ],
        ),
      );
    } else if (_weather == null) {
      body = const Center(child: CircularProgressIndicator());
    }
    else{
      body = ListView.builder(
          itemCount: 1,
          itemBuilder: (context,index){
            var weathers = _weather!;
            return Column(
              children: [
                Text(weathers!.city,
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 35.0
                  ),
                ),
                Text(weathers.country,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0
                  ),
                ),
                Text(weathers.lastUpdated,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10.0
                  ),
                ),
                //(weathers.condition.icon),
                Image.network(weathers.condition.icon),
                Text(weathers.condition.text,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  ),
                ),
                Text(weathers.tempC.toString(),style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45.0,
                ),),
                Text(weathers.feelsLikeC.toString(),style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),),
                Text(weathers.tempF.toString(),style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45.0,
                ),),
                Text(weathers.feelsLikeF.toString(),style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),),

                Row(
                  children: [
                    Row(
                      children: [
                        Text(weathers.humidity.toString()),
                      ],

                    ),
                    Text(weathers.windKph.toString()),
                    Text(weathers.windMph.toString()),
                    Text(weathers.uv.toString(),
                    ),
                  ],
                ),
              ],
            );
          }
      );
    }
    
    
    
    return Scaffold(body: body,appBar: AppBar(title: Text('Bangkok'),

    ),
    );
  }
}
