import 'package:dio/dio.dart';
import 'package:egrxdart/model/climateModel.dart';
import 'package:egrxdart/retrofit/api_client.dart';
import 'package:egrxdart/services/services.dart';

class Repository {
  //Services apiServices = Services();

  final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));

  Future<ClimateModel> fetchClimatedata() => client.fetchClimate();
}
