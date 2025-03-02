import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skysignal/getX_controller/search_controller.dart';
import '../provider/theme_provider.dart';
import '../reuse_widgets/my_app_bar.dart';
import 'build_home_ui.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  final SearchControllerX searchControllerX = Get.find<SearchControllerX>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: MyAppBar(title: "Search Location"),
      ),


      body: SafeArea(
        child: Stack(
          children: [

            Consumer<ThemeProvider>(
              builder: (context, value, widget) {
                return Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: value.changeTheme == ThemeMode.light? [const Color(0xfffff1eb), const Color(0xfface0f9)] // Light theme gradient colors
                          :[const Color(0xff434343), const Color(0xff000000)], // Dark theme gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                );
              },
            ),



            Column(
              children: [
                // search bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    elevation: 4,
                    color: Theme.of(context).secondaryHeaderColor,
                    child: ListTile(
                      leading: const Icon(Icons.search),
                      trailing: IconButton(
                        onPressed: () => searchControllerX.searchTextController.clear(),
                        icon: const Icon(Icons.clear, size: 16),
                      ),
                      title: TextFormField(
                        controller: searchControllerX.searchTextController,
                        onFieldSubmitted: (value) {
                          searchControllerX.searchLocation(value.toLowerCase().trim());
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search for a location...",
                        ),
                      ),
                    ),
                  ),
                ),


                // loading indicator
                Obx(()=> searchControllerX.isSearching.value? const Padding(
                  padding: EdgeInsets.all(5),
                  child: SpinKitWave(color: Colors.blue),
                ):const SizedBox.shrink()),


                // recent searches header
                Obx(()=>searchControllerX.searchHistory.isNotEmpty?const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Recent Search", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ):const SizedBox.shrink()),


                // search history list
                Expanded(
                  child: Obx(()=> ListView.builder(
                    itemCount: searchControllerX.searchHistory.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(searchControllerX.searchHistory[index]),
                        // subtitle: Text("Coordinates: ${searchControllerX.coordinatesList[index]}"),
                        trailing: IconButton(
                          onPressed: ()=>searchControllerX.removeLocation(index),
                          icon: Icon(Icons.delete, color: Colors.red.shade300),
                        ),
                        onTap: (){
                          Get.to(()=> BuildHomeUi(location: searchControllerX.coordinatesList[index]));
                        },
                      );
                    },
                  )
                  ),
                ),
              ],
            ),

          ],
        )
      ),
    );
  }
}
