import 'package:flutter/material.dart';
import 'package:ruana_days/services/location.dart';
import 'package:ruana_days/services/weather.dart';
import 'package:ruana_days/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double temp;

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  void getLocation() async {
    Location location = Location();
    Weather weather = Weather();
    await location.getCurrentLocation();
    var weatherData =
        await weather.fetchCurrentWeatherData(location.lat, location.long);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherData: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 80,
        ),
      ),
    );
  }
}
