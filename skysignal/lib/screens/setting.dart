import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skysignal/provider/theme_provider.dart';
import '../reuse_widgets/my_app_bar.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const PreferredSize(preferredSize: Size.fromHeight(kToolbarHeight),
          child: MyAppBar(title: "Weather")
      ),


      body: SafeArea(
        child: SingleChildScrollView(
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

                Consumer<ThemeProvider>(
                  builder: (context,value,widget){
                    return ExpansionTile(
                      title: const Text("Change Theme"),
                      shape: const RoundedRectangleBorder(),
                      children: [
                        ListTile(leading: const Icon(Icons.dark_mode),title: const Text("Dark Theme"),onTap: (){
                          value.changeDeviceTheme(ThemeMode.dark);
                        },),
                        ListTile(leading: const Icon(Icons.wb_sunny),title: const Text("Light Theme"),onTap: (){
                          value.changeDeviceTheme(ThemeMode.light);
                        },),
                      ],
                    );
                  },
                ),

                const ExpansionTile(
                  title: Text("Frequently asked questions?"),
                  shape: RoundedRectangleBorder(),
                  children: [
                    ListTile(
                      title: Text("How to add new location?"),
                      subtitle: Text("Open menu-bar search for your location then press add button to save your location."),
                    ),
                    ListTile(
                      title: Text("How to search?"),
                      subtitle: Text("Open menu-bar search for your specific location as you want."),
                    ),
                  ],
                ),


                const ExpansionTile(
                  title: Text("Terms and Conditions."),
                  shape: RoundedRectangleBorder(),
                  children: [
                    ListTile(
                      title: Text("User Conduct:"),
                      subtitle: Text("You agree to use the app in a lawful manner and not to engage in any activities that could harm others or violate any laws."),
                    ),
                    ListTile(
                      title: Text("Limitation of Liability:"),
                      subtitle: Text("The app provider is not responsible for any damages or losses that result from the use of the app."),
                    ),
                    ListTile(
                      title: Text("Termination:"),
                      subtitle: Text("The app provider can terminate your access to the app if you violate these terms."),
                    ),
                  ],
                ),


              ],
            ),
           ]
          ),
        ),
      ),

      bottomSheet: SizedBox(
          width: Get.width*.5,
          child: const Text("App version 2.6.11.03",textAlign: TextAlign.center,style: TextStyle(color: Colors.pink),)),

    );
  }
}

