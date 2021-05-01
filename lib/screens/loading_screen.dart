import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.longitude);
    print(location.latitude);
  }

  void getData() async {
    Uri uri = Uri.http("api.openweathermap.org", "/data/2.5/weather", {
      'lat': '39',
      'lon': '139',
      'appid': '5395ac65622d176519bdd00654f3331f',
    });

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = convert.jsonDecode(data);

      int longitude = decodedData["coord"]["lon"];

      print(longitude);

      String weatherDesc = decodedData["weather"][0]["description"];

      print(weatherDesc);

      int weatherID = decodedData["weather"][0]["id"];

      print(weatherID);

      double temp = decodedData["main"]["temp"];

      print(temp);

      String placeName = decodedData["name"];

      print(placeName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
