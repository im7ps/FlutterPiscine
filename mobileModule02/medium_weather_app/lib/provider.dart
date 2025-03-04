import 'package:flutter/material.dart';
import 'tab_bar_view.dart';

class SearchProvider extends ChangeNotifier {
  String _location = "";
  List<List<WeatherData>> _weatherDataList = [];

  String get location => _location;
  List<List<WeatherData>> get weatherDataList => _weatherDataList;


  void updateLocation(String newLocation) {
    _location = newLocation;
    notifyListeners();
  }

  void updateWeatherData(List<List<WeatherData>> newWeatherData) {
    _weatherDataList = newWeatherData;
    notifyListeners();
  }

}