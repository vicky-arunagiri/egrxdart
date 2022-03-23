import 'package:dio/dio.dart';
import 'package:egrxdart/model/climateModel.dart';
import 'package:egrxdart/retrofit/apis.dart';
import 'package:retrofit/http.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "https://samples.openweathermap.org/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Apis.country)
  Future<ClimateModel> fetchClimate();
}
