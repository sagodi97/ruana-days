import 'package:flutter/material.dart';
import 'package:ruana_days/services/weather_model.dart';
import 'package:ruana_days/services/location.dart';
import 'package:ruana_days/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  LocationScreen({this.weatherData});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temp;
  int feelsLike;
  int condition;
  String city;
  Location location;
  Weather weather;
  bool _loading = false;

  RuanaLogic clima;
  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
    location = Location();
    weather = Weather();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      temp = weatherData['main']['temp'].round();
      feelsLike = weatherData['main']['feels_like'].round();
      condition = weatherData['weather'][0]["id"];
      city = weatherData['name'];
      clima = RuanaLogic(condition: condition, temp: feelsLike);
      _loading = false;
    });
  }

  Future<dynamic> updateData() async {
    setState(() {
      _loading = true;
    });
    await location.getCurrentLocation();
    var data =
        await weather.fetchCurrentWeatherData(location.lat, location.long);

    return data;
  }

  List<Widget> _buildLocationScreen() {
    Container locationScreen = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/location_background.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      ),
      constraints: BoxConstraints.expand(),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(8, 30, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var newData = await updateData();
                      updateUI(newData);
                    },
                    color: Color.fromRGBO(250, 250, 250, 0.3),
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'images/ruana.png',
                          width: 70,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            Text(
                              ' $city',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 350,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(20, 0, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$temp°',
                    style: TextStyle(
                      fontSize: 90,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Feels like $feelsLike°',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(90),
                ),
                color: Color.fromRGBO(250, 250, 250, 0.7),
              ),
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Ruana status:",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    var l = List<Widget>();
    l.add(locationScreen);
    if (_loading) {
      var loadingAnimation = Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          Center(
            child: SpinKitDoubleBounce(
              color: Colors.white,
              size: 80,
            ),
          ),
        ],
      );
      l.add(loadingAnimation);
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: _buildLocationScreen(),
      ),
    );
  }
}
