import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wether_app/model/api/api.dart';
import '../../constant.dart';

class WeatherNotifier extends ChangeNotifier {
  final apiObj = new ApiService();
  var position;
  List<Map<dynamic, dynamic>> _day1 = [];
  List<Map<dynamic, dynamic>> _day2 = [];
  List<Map<dynamic, dynamic>> _day3 = [];
  List<Map<dynamic, dynamic>> _day4 = [];
  List<Map<dynamic, dynamic>> _day5 = [];
  List<Map<dynamic, dynamic>> _day6 = [];
  bool _dataLoading = false;
  bool _yesterdayExist = false;
  var _allData = [];
  String date1 = '';
  String date2 = '';
  String date3 = '';
  String date4 = '';
  String date5 = '';
  String date6 = '';
  String date = '';
  String _location = '';
  String _currentDate = '';
  final today = DateTime.now();

  WeatherNotifier(this.position) {
    getWeatherData(position);
  }

  get dataLoading => _dataLoading;

  get yesterdayExist => _yesterdayExist;

  get day1 => _day1;

  get day2 => _day2;

  get day3 => _day3;

  get day4 => _day4;

  get day5 => _day5;

  get day6 => _day6;

  get allData => _allData;

  get location => _location;

  get currentDate => _currentDate;

  Future getWeatherData(position) async {
    _dataLoading = true;
    final d1 = DateTime(today.year, today.month, today.day);
    final d2 = DateTime(today.year, today.month, today.day + 1);
    final d3 = DateTime(today.year, today.month, today.day + 2);
    final d4 = DateTime(today.year, today.month, today.day + 3);
    final d5 = DateTime(today.year, today.month, today.day + 4);
    final d6 = DateTime(today.year, today.month, today.day + 5);
    final d = DateTime(today.year, today.month, today.day - 1);
    date1 = _currentDate = DateFormat(dateFormat).format(d1);
    date2 = DateFormat(dateFormat).format(d2);
    date3 = DateFormat(dateFormat).format(d3);
    date4 = DateFormat(dateFormat).format(d4);
    date5 = DateFormat(dateFormat).format(d5);
    date6 = DateFormat(dateFormat).format(d6);
    date = DateFormat(dateFormat).format(d);
    var response =
        await apiObj.fetchNewsData(position.latitude, position.longitude);
    var weatherList = response['list'];
    String nowdate = response['list'][0]['dt_txt'].split(' ')[0];
    if (date == nowdate) {
      _yesterdayExist = true;
    }
    _location = response['city']['name'];
    weatherList.forEach((element) {
      var dateTimeSplit = element['dt_txt'].split(' ');
      if (date1 == dateTimeSplit[0]) {
        _day1.add({
          "main": element['main'],
          "weather": element['weather'][0],
          "wind": element['wind'],
          "date": dateTimeSplit[0],
          "time": dateTimeSplit[1].toString(),
        });
      }
      if (date2 == dateTimeSplit[0]) {
        _day2.add({
          "main": element['main'],
          "weather": element['weather'][0],
          "wind": element['wind'],
          "date": dateTimeSplit[0],
          "time": dateTimeSplit[1],
        });
      }
      if (date3 == dateTimeSplit[0]) {
        _day3.add({
          "main": element['main'],
          "weather": element['weather'][0],
          "wind": element['wind'],
          "date": dateTimeSplit[0],
          "time": dateTimeSplit[1],
        });
      }
      if (date4 == dateTimeSplit[0]) {
        _day4.add({
          "main": element['main'],
          "weather": element['weather'][0],
          "wind": element['wind'],
          "date": dateTimeSplit[0],
          "time": dateTimeSplit[1],
        });
      }
      if (date5 == dateTimeSplit[0]) {
        _day5.add({
          "main": element['main'],
          "weather": element['weather'][0],
          "wind": element['wind'],
          "date": dateTimeSplit[0],
          "time": dateTimeSplit[1],
        });
      }
      if (date6 == dateTimeSplit[0]) {
        _day6.add({
          "main": element['main'],
          "weather": element['weather'][0],
          "wind": element['wind'],
          "date": dateTimeSplit[0],
          "time": dateTimeSplit[1],
        });
      }
    });
    allData.add(day1);
    allData.add(day2);
    allData.add(day3);
    allData.add(day4);
    allData.add(day5);
    allData.add(day6);
    _dataLoading = false;
    notifyListeners();
  }
}
