import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchControllerX extends GetxController {

  var searchHistory = <String>[].obs;
  var coordinatesList = <String>[].obs;
  var isSearching = false.obs;

  TextEditingController searchTextController = TextEditingController();


  Future<void> saveCurrentLocation(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        String address = "${placemarks.first.locality}, ${placemarks.first.country}";
        String coordinates = "${latLng.latitude},${latLng.longitude}";

        if (!searchHistory.contains(address)) {
          searchHistory.insert(0, address);
          coordinatesList.insert(0, coordinates);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Unable to get address", snackPosition: SnackPosition.BOTTOM);
    }
  }


  Future<void> searchLocation(String address) async {
    if (address.isEmpty) return;

    try {
      isSearching.value = true;
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        String coordinates = "${locations[0].latitude},${locations[0].longitude}";

        if (!searchHistory.contains(address)) {
          searchHistory.insert(0, address);
          coordinatesList.insert(0, coordinates);
        }
        searchTextController.clear();
      }
    } catch (e) {
      Get.snackbar("Error", "Location not found", snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSearching.value = false;
    }
  }

  void removeLocation(int index) {
    searchHistory.removeAt(index);
    coordinatesList.removeAt(index);
  }
}

