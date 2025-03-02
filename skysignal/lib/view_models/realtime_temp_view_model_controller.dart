import 'package:get/get.dart';
import 'dart:convert';
import 'package:skysignal/models/realtime_temperature_model.dart';
import 'package:http/http.dart' as http;
import '../api_keys.dart';

class RealtimeTempViewModelController extends GetxController {

  RxBool isLoading = false.obs;
  Rx<RealTimeTemperatureModel?> realTimeTemp = Rx<RealTimeTemperatureModel?>(null);

  static const String apiKey = ApiKeys.weatherApi;


  Future<void> fetchRealTempData(String location) async {
    location=location.replaceAll(',',' ').replaceAll(' ', '+');
    try {
      isLoading.value = true;
      var response = await http.get(Uri.parse(
        "https://api.tomorrow.io/v4/weather/realtime?location=$location&apikey=$apiKey"
      ));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        realTimeTemp.value = RealTimeTemperatureModel.fromJson(jsonData);
      } else {
        throw Exception("Unable to fetch realtime API data");
      }
    } finally {
      isLoading.value = false;
    }
  }


}
