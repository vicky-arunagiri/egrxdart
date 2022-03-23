import 'dart:async';
import 'dart:convert';
import 'package:egrxdart/model/climateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Services {
  static const String baseUrl =
      "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22";

  Future<ClimateModel> fetchClimate() async {
    try {
      final response = await get(
        Uri.parse(baseUrl),
      );
      print('response code :${response.statusCode}');
      if (response.statusCode == 200) {
        print('response data : ${response.body}');

        ClimateModel climatedata = climateModelFromJson(response.body);

        return climatedata;
      } else {
        throw Exception('Not getting datas');
      }
    } catch (e) {
      throw Exception('Failed');
    }
  }
}
