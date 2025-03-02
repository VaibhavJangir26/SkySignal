import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:skysignal/getX_controller/search_controller.dart';
import 'package:skysignal/provider/internet_connection_check_provider.dart';
import 'package:skysignal/utilities/no_internet_screen.dart';
import 'build_home_ui.dart';
import 'menuBar_screen.dart';
import 'current_location_weather.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PersistentTabController navbarController = PersistentTabController();
  final SearchControllerX searchBarController = Get.put(SearchControllerX());

  Future<bool> _onWillPop() async {
    if (navbarController.index == 0) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  List<Widget> _buildScreens() {
    return [
      Obx(() => WillPopScope(
        onWillPop: _onWillPop,
        child: BuildHomeUi(
          location: searchBarController.coordinatesList.isNotEmpty
              ? searchBarController.coordinatesList[0]
              : "20.5937,78.9629", // default to India coordinates
        ),
      )
      ),

      const MyCurrentLocation(),
      const MenuScreen(),

    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        inactiveIcon: const Icon(Icons.home_outlined),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        title: "Home",
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.map),
        inactiveIcon: const Icon(Icons.map_outlined),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        title: "Map",
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.menu),
        inactiveIcon: const Icon(Icons.menu_outlined),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        title: "More",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InternetConnectionCheckProvider>(
        builder: (context,value,widget){
          return value.isConnectedToInternet? PersistentTabView(
            context,
            controller: navbarController,
            screens: _buildScreens(),
            items: _navBarItems(),
            navBarStyle: NavBarStyle.style3,
            backgroundColor: Theme.of(context).secondaryHeaderColor,
          ): const NoInternetScreen();
        }

      ),
    );
  }
}
