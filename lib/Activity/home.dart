import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'dart:core';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    print("This is a init state.");
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget destroyed");
  }

  @override
  Widget build(BuildContext context) {
    var city_name = ["Mumbai", "Chennai", "Pune"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    Map info = ModalRoute.of(context)?.settings.arguments as Map;

    String temp = ((info["temp_value"]).toString());
    String air = ((info["air_speed_value"]).toString());
    if (temp == "NA") {
      print("NA");
    } else {
      temp = ((info["temp_value"]).toString()).substring(0, 4);
      air = ((info["air_speed_value"]).toString()).substring(0, 4);
    }

    String icon = info['icon_value'];
    String cityname = info['city_value'];
    String hum = info['hum_value'];
    String desc = info['desc_value'];
    String main = info['main_value'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            //Home page container
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue, Colors.green])),
            child: Column(
              children: <Widget>[
                Container(
                  //Search box container
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),

                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (searchController.text == "") {
                            print("Blank Search");
                          } else {
                            Navigator.pushReplacementNamed(context, "/loading",
                                arguments: {
                                  "searchText": searchController.text,
                                });
                          }
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search places",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          padding: EdgeInsets.all(10),
                          child: Row(children: [
                            Image.network(
                                "https://openweathermap.org/img/wn/$icon@2x.png"),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: [
                                Text(
                                  "$desc",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "in $cityname",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            )
                          ])),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          padding: EdgeInsets.all(50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.wiThermometer),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "$temp",
                                    style: TextStyle(
                                      fontSize: 100,
                                    ),
                                  ),
                                  Text(
                                    "C",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          padding: EdgeInsets.all(35),
                          height: 200,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.wiDayWindy),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "$air",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "km/hr",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        padding: EdgeInsets.all(35),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.wiHumidity),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "$hum",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "%",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text("Made by Sourav Mane"),
                      Text("Credits: openweathermap.org")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
