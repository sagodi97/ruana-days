class RuanaLogic {
  int temp;
  int condition;
  double windSpeed;

  RuanaLogic({this.condition, this.temp, this.windSpeed});

  bool isItARuanaDay() {
    if (temp > 10 && temp < 20 && condition > 700) {
      if (windSpeed < 10) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  String getWeatherIcon() {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
    if (temp > 25) {
      return 'It\'s 🧊🍺 time, no need for ruana today';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (this.isItARuanaDay()) {
      return 'That\'s y\'all, it is ruana day';
    } else if (temp < 10) {
      return 'Too cold for a ruana :( , you\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
