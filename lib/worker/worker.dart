import 'package:http/http.dart';
import 'dart:convert';

class worker
{
  late String location;

  worker({required this.location})
  {
    location = this.location;
  }

  late String temp;
  late String humidity;
  late String airspeed;
  late String description;
  late String main;
  late String icon;

  Future<void> getData() async
  {
    try{
      Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=05efb9dba7fa862da7748eaec9d33544"));
      Map data = jsonDecode(response.body);

      //temp,humidity
      Map temp_data = data['main'];
      String getHumidity = temp_data['humidity'].toString();
      double getTemp = temp_data['temp'] - 273.15;

      //airspeed
      Map wind = data['wind'];
      double getAir_speed = wind['speed']/0.277778 ;

      //description,main
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data['description'];

      temp = getTemp.toString();
      humidity = getHumidity;
      airspeed = getAir_speed.toString();
      description = getDesc;
      main = getMain_des;
      icon = weather_main_data['icon'].toString() ;

    }catch(e) {
      temp = "NA";
      humidity = "NA";
      airspeed = "NA";
      description = "Can't find data";
      main = "NA";
      icon = "01d";

    }

  }
}

worker instance = worker(location: "Mumbai");
