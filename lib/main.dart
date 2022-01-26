import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  var sunrise;
  var feels_like;
  var sunset;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Krasnoyarsk&units=metric&appid=03ff53019f289e63ca2a10af14e58d8d"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.sunrise = results['sys']['sunrise'];
      this.feels_like = results['main']['feels_like'];
      this.sunset = results['sys']['sunset'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Погода в Красноярске",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              temp != null ? temp.toString() + "\u00B0" : "Loading",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                currently != null ? currently.toString() : "Loading",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      Expanded(
          child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(children: <Widget>[
                ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerThreeQuarters),
                    title: Text("Temperature"),
                    trailing: Text(
                        temp != null ? temp.toString() + "\u00B0" : "Loading")),
                ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description != null
                        ? description.toString()
                        : "Loading")),
                ListTile(
                    leading: FaIcon(FontAwesomeIcons.bug),
                    title: Text("Humidity"),
                    trailing: Text(
                        humidity != null ? humidity.toString() : "Loading")),
                ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(
                        windSpeed != null ? windSpeed.toString() : "Loading")),
                ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Sunrise"),
                    trailing:
                        Text(sunrise != null ? sunrise.toString() : "Loading")),
                ListTile(
                    leading: FaIcon(FontAwesomeIcons.beer),
                    title: Text("Sunset"),
                    trailing:
                        Text(sunset != null ? sunset.toString() : "Loading")),
                ListTile(
                    leading: FaIcon(FontAwesomeIcons.wineBottle),
                    title: Text("Feels Like"),
                    trailing: Text(feels_like != null
                        ? feels_like.toString()
                        : "Loading")),
              ])))
    ]));
  }
}
