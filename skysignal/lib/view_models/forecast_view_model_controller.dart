import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart' as geo;
import 'package:skysignal/api_keys.dart';
import 'package:skysignal/models/forecast_model.dart';

class ForecastViewModelController extends GetxController {
  Rx<ForecastModel?> forecastData = Rx<ForecastModel?>(null);
  RxBool isDaytimeNow = false.obs;
  RxBool isLoading = false.obs;

  static const String apiKey = ApiKeys.weatherApi;

  Future<void> fetchForecastData(String location) async {
    try {
      isLoading.value = true;

      String formattedLocation = location.replaceAll(',', ' ').replaceAll(' ', '+');
      final url = "https://api.tomorrow.io/v4/weather/forecast?location=$formattedLocation&apikey=$apiKey";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        forecastData.value = ForecastModel.fromJson(jsonData);
        await fetchLatLngForDaytimeCheck(location);
      } else {
        throw Exception("Unable to fetch forecast API data");
      }
    } catch (e) {
      print("Error fetching forecast: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // convert location string to lat/lng (only for checking day/night status)
  Future<void> fetchLatLngForDaytimeCheck(String location) async {
    try {
      List<geo.Location> locations = await geo.locationFromAddress(location);
      if (locations.isNotEmpty) {
        double lat = locations.first.latitude;
        double lng = locations.first.longitude;
        // Use lat/lng to check if it's day or night
        await updateDaytimeStatus(lat, lng);
      } else {
        throw Exception("Unable to find location for day/night check");
      }
    } catch (e) {
      print("Error fetching lat/lng for daytime check: $e");
    }
  }

  // fetches sunrise and sunset times to determine if it's daytime
  Future<void> updateDaytimeStatus(double lat, double lng) async {
    final url = Uri.parse(
        'https://api.sunrise-sunset.org/json?lat=$lat&lng=$lng&formatted=0');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        DateTime sunrise = DateTime.parse(data['results']['sunrise']).toLocal();
        DateTime sunset = DateTime.parse(data['results']['sunset']).toLocal();
        DateTime now = DateTime.now();

        isDaytimeNow.value = now.isAfter(sunrise) && now.isBefore(sunset);
      } else {
        throw Exception("Failed to load sunrise-sunset data");
      }
    } catch (e) {
      print("Error fetching day/night status: $e");
    } finally {
      update();
    }
  }




  // determines if the given time is daytime based on an approximate sunrise/sunset time.
  bool isDaytimeForDate(DateTime dateTime) {
    final DateTime sunrise = DateTime(dateTime.year, dateTime.month, dateTime.day, 6, 0, 0).toUtc(); // 6:00 am UTC
    final DateTime sunset = DateTime(dateTime.year, dateTime.month, dateTime.day, 18, 0, 0).toUtc(); // 6:00 pm UTC

    return dateTime.isAfter(sunrise) && dateTime.isBefore(sunset);
  }


}

