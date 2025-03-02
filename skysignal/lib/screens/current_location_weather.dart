import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:skysignal/getX_controller/search_controller.dart';

class MyCurrentLocation extends StatefulWidget {
  const MyCurrentLocation({super.key});

  @override
  State<MyCurrentLocation> createState() => _MyCurrentLocationState();
}

class _MyCurrentLocationState extends State<MyCurrentLocation> {


  Completer<GoogleMapController> mapController = Completer();
  LatLng? currentPosition;
  bool hasLocationPermission = false;
  Marker? currentMarker;

  final SearchControllerX searchControllerX = Get.put(SearchControllerX());

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Location Permission", "Please enable location services.", snackPosition: SnackPosition.BOTTOM);
        Geolocator.openLocationSettings();
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Location Permission", "Enable location access in settings.", snackPosition: SnackPosition.BOTTOM);
      Geolocator.openLocationSettings();
    }
    setState(() {
      hasLocationPermission = true;
    });
  }

  Future<void> _getCurrentLocation() async {
    if (!hasLocationPermission) {
      Get.snackbar("Permission Required", "Enable location services first.", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.best));

    LatLng newPosition = LatLng(position.latitude, position.longitude);

    setState(() {
      currentPosition = newPosition;
      currentMarker = Marker(
        markerId: const MarkerId("current_location"),
        position: newPosition,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onDragEnd: (LatLng newPosition) {
          setState(() {
            currentPosition = newPosition;
          });
        },
      );
    });

    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(currentPosition!, 15));

    await searchControllerX.saveCurrentLocation(currentPosition!);

    Get.snackbar("Navigate", "Go to more screen to see the weather of current location", duration: const Duration(seconds: 1));
  }

  Future<void> _saveAddressToHistory() async {
    if (currentPosition != null) {
      await searchControllerX.saveCurrentLocation(currentPosition!);
      Get.snackbar("Address Saved", "The address has been saved to search history.", duration: const Duration(seconds: 1));
    } else {
      Get.snackbar("Error", "Please select a location first.", snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(


      appBar: AppBar(title: const Text("Sky Signal"),backgroundColor: Theme.of(context).secondaryHeaderColor,),
      extendBodyBehindAppBar: true,

      body: Stack(
        children: [


          GoogleMap(
            initialCameraPosition: const CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 5),
            myLocationEnabled: hasLocationPermission,
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              mapController.complete(controller);
            },
            markers: currentMarker != null ? {currentMarker!} : {},
            onTap: (LatLng position) {
              setState(() {
                currentMarker = Marker(
                  markerId: const MarkerId("selected_location"),
                  position: position,
                  draggable: true,
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                  onDragEnd: (LatLng newPosition) {
                    setState(() {
                      currentPosition = newPosition;
                    });
                  },
                );
                currentPosition = position;
              });
            },
          ),

          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: _saveAddressToHistory,
              child: const Text("Save Address"),
            ),
          ),
        ],
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        shape: const StadiumBorder(),
        child: const Icon(Icons.my_location),
      ),


    );
  }
}



