import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var temp, weather, humidity, wind;
  String city = '';
  double latData;
  double longData;
  List<Marker> marker = [];

  IconsData() {
    switch (weather) {
      case "rain":
        {
          return WeatherIcons.rain_mix;
        }
        break;
      case "overcast clouds":
        {
          return WeatherIcons.cloud;
        }
        break;
      case "clear sky":
        {
          return WeatherIcons.sunrise;
        }
        break;
      case "haze":
        {
          return WeatherIcons.day_haze;
        }
        break;
      default:
        {
          return WeatherIcons.rain_mix;
        }
        break;
    }
  }

  backgroundImage() {
    switch (weather) {
      case "rain":
        {
          return AssetImage('assets/images/rain.jpg');
        }
      case "overcast clouds":
        {
          return AssetImage('assets/images/cloud.jpg');
        }
        break;
      case "broken clouds":
        {
          return AssetImage('assets/images/cloud.jpg');
        }
        break;
      case "clear sky":
        {
          return AssetImage('assets/images/clear.jpg');
        }
        break;
      case "haze":
        {
          return AssetImage('assets/images/sunny.jpg');
        }
        break;
      default:
        {
          return AssetImage('assets/images/clear.jpg');
        }
        break;
    }
  }

  Future<void> getWeatherData() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=" +
            city +
            "&appid=aa0c1733f3b8a6d6a9a5d10b82864b17"));

    var result = jsonDecode(response.body);

    setState(() {
      this.temp = result['main']['temp'];
      this.weather = result['weather'][0]['description'];
      this.humidity = result['main']['humidity'];
      this.wind = result['wind']['speed'];
      //this.icon = result ['weather'] [0] ['icon'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Center(child: Text("Weather Report of Several Cities"))),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: new Stack(
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: backgroundImage(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new Center(
                child: Column(
                  children: [
                    Icon(
                      IconsData(),
                      size: 80,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.06,
                    ),
                    Text("Currently weather of " + city + " is"),
                    Text(
                      temp != null ? temp.toString() + '\u00B0' : "Loading",
                    ),
                    Text(
                      weather != null ? weather.toString() : "Loading",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          IconsData(),
                          size: 30,
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text("Temperature"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.1,
                        ),
                        Text(
                          temp != null ? temp.toString() + '\u00B0' : "Loading",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Weather"),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          weather != null ? weather.toString() : "Loading",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Humidity"),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          humidity != null ? humidity.toString() : "Loading",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Wind speed"),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          wind != null ? wind.toString() + '\u00B0' : "Loading",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.05,
                    ),
                    Center(
                        child: Text(
                      "Please Select a City",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              city = "Dhaka";
                              backgroundImage();
                              getWeatherData();
                            });
                          },
                          color: Colors.green,
                          child: Text("DHAKA",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        FlatButton(
                            onPressed: () {
                              setState(() {
                                backgroundImage();
                                city = "khulna";
                                getWeatherData();
                              });
                            },
                            color: Colors.green,
                            child: Text(
                              "KHULNA",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        FlatButton(
                            onPressed: () {
                              setState(() {
                                city = "Chittagong";
                                backgroundImage();
                                getWeatherData();
                              });
                            },
                            color: Colors.green,
                            child: Text(
                              "CHITTAGONG",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        FlatButton(
                            onPressed: () {
                              setState(() {
                                city = "Rangpur";
                                getWeatherData();
                                backgroundImage();
                              });
                            },
                            color: Colors.green,
                            child: Text(
                              "RANGPUR",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                            onPressed: () {
                              setState(() {
                                city = "Rajshahi";
                                getWeatherData();
                                backgroundImage();
                              });
                            },
                            color: Colors.green,
                            child: Text(
                              "RAJSHAHI",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.01,
                        ),
                        FlatButton(
                            color: Colors.green,
                            onPressed: () {
                              setState(() {
                                city = "Sylhet";
                                getWeatherData();
                                backgroundImage();
                              });
                            },
                            child: Text(
                              "SYLHET",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.01,
                        ),
                        FlatButton(
                            onPressed: () {
                              city = "Mymensingh";
                              getWeatherData();
                              backgroundImage();
                            },
                            color: Colors.green,
                            child: Text(
                              "MYMENSINGH",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.01,
                        ),
                        FlatButton(
                            onPressed: () {
                              city = "Barisal";
                              getWeatherData();
                              backgroundImage();
                            },
                            color: Colors.green,
                            child: Text(
                              "BARISAL",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
